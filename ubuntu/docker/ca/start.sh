#!/bin/bash
source /helper.sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
# /usr/sbin/incrond

# Start sshd
# /usr/sbin/sshd


# -------------------------------------------
# Set environment variables
# -------------------------------------------

CA_DOMAIN=`getenv CA_DOMAIN localhost`
CA_NAME=`getenv CA_NAME 'Certificate Authority'`
COUNTRY=`getenv COUNTRY $(curl -s ipinfo.io/country)`
REGION=`getenv REGION $(curl -s ipinfo.io/region)`
CITY=`getenv CITY $(curl -s ipinfo.io/city)`
ORG="$CA_DOMAIN CA"


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# nginx
cp -f /config/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# openssl
cp -f /config/openssl.cnf /usr/lib/ssl/openssl.cnf
expenv CA_DOMAIN /usr/lib/ssl/openssl.cnf
expenv CA_NAME /usr/lib/ssl/openssl.cnf
expenv COUNTRY /usr/lib/ssl/openssl.cnf
expenv REGION /usr/lib/ssl/openssl.cnf
expenv CITY /usr/lib/ssl/openssl.cnf
expenv ORG /usr/lib/ssl/openssl.cnf


# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Create directory structure
mkdir -p /config/ca
mkdir -p /config/db
mkdir -p /config/crl
mkdir -p /config/certs
mkdir -p /config/newcerts

# Flat file database
[ -f /config/db/index ] || touch /config/db/index
[ -f /config/db/serial ] || echo 1000 > /config/db/serial
[ -f /config/crl/crlnumber ] || echo 1000 > /config/crl/crlnumber

# Certificate variables
ORG="$CA_DOMAIN CA"
UNIT="Certificate Authority"
NAME="$CA_NAME"
EMAIL="ca@$CA_DOMAIN"

# Generate the certificate authority key
[ -f /config/ca/ca.key ] || 
openssl genrsa -out /config/ca/ca.key 2048
chmod 400 /config/ca/ca.key

# Generate the certificate authority certificate
[ -f /config/ca/ca.crt ] || 
openssl req -new -x509 -nodes -days 3650 -extensions v3_ca                              \
  -subj "/C=$COUNTRY/ST=$REGION/L=$CITY/O=$ORG/OU=$UNIT/CN=$NAME/emailAddress=$EMAIL/"  \
  -key /config/ca/ca.key                                                                \
  -out /config/ca/ca.crt

# Generate the certificate revocation list
openssl ca -gencrl                                                                      \
  -keyfile /config/ca/ca.key                                                            \
  -cert /config/ca/ca.crt                                                               \
  -out /config/crl/ca.crl

# ------ END OF START -------- #


# Start 
cd /config 
npm install
npm start


# Tail the logs and keep the container alive
# tail -F /var/log/nginx/*

# /usr/sbin/service mysql start

# Tail the logs and keep the container alive
# tail -F /var/log/mysql.log
