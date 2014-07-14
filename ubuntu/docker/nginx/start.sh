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

# Get the server key & crt, and the ca crt & crl
curl "$CA_SERVER/*.$DOMAIN.key" > /config/my.key
curl "$CA_SERVER/*.$DOMAIN.crt" > /config/my.crt
curl "$CA_SERVER/ca.crt" > /config/ca.crt
curl "$CA_SERVER/ca.crl" > /config/ca.crl

# Put it together
cat /config/my.crt /config/my.key > /config/my.pem
chmod 600 /config/my.key /config/my.pem

# Start the service
/usr/sbin/nginx

# Tail the logs and keep the container alive
tail -F /var/log/nginx/*
