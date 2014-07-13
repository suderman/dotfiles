#!/bin/bash
source /helper.sh

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
# Restart this container's services
# -------------------------------------------

# Restart services
/usr/sbin/service php5-fpm reload
/usr/sbin/nginx -s reload
