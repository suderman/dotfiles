#!/bin/bash
source /helper.sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
/usr/sbin/incrond

# Start sshd
/usr/sbin/sshd


# -------------------------------------------
# Set environment variables
# -------------------------------------------

DOMAIN=`getenv DOMAIN localhost`
HOST_IP=`getenv HOST_IP localhost`
GATEWAY_IP=`getenv GATEWAY_IP localhost`
CA_SERVER=`getenv CA_SERVER localhost`


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

cp -f /config/nginx.conf    /etc/nginx/sites-enabled/nginx.conf
cat /config/nginx.*.conf >> /etc/nginx/sites-enabled/nginx.conf
expenv DOMAIN               /etc/nginx/sites-enabled/nginx.conf
expenv HOST_IP              /etc/nginx/sites-enabled/nginx.conf
expenv GATEWAY_IP           /etc/nginx/sites-enabled/nginx.conf

# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Get the server key & pem, and the ca crt & crl
curl "$CA_SERVER/*.$DOMAIN.key" > /config/my.key
curl "$CA_SERVER/*.$DOMAIN.pem" > /config/my.pem
curl "$CA_SERVER/ca.crt" > /config/ca.crt
curl "$CA_SERVER/ca.crl.pem" > /config/ca.crl
chmod 600 /config/my.key /config/my.pem

# Get the revoked server key & crt
(has /config/revoked.key) || curl "$CA_SERVER/revoked.$DOMAIN.key" > /config/revoked.key
(has /config/revoked.pem) || curl "$CA_SERVER/revoked.$DOMAIN.pem" > /config/revoked.pem
chmod 600 /config/revoked.key /config/revoked.pem


# Start the service
/usr/sbin/nginx

# Tail the logs and keep the container alive
tail -F /var/log/nginx/*
