#!/bin/bash
source /helper.sh

# Set environment variables
DOMAIN=`getenv DOMAIN localhost`
CA_NAME=`getenv CA_NAME 'Certificate Authority'`
COUNTRY=`getenv COUNTRY $(curl -s ipinfo.io/country)`
REGION=`getenv REGION $(curl -s ipinfo.io/region)`
CITY=`getenv CITY $(curl -s ipinfo.io/city)`
ORG="ca.$DOMAIN CA"


# Copy config files to where they're expected
cp -f /config/openssl.cnf /usr/lib/ssl/openssl.cnf

expenv DOMAIN /usr/lib/ssl/openssl.cnf
expenv CA_NAME /usr/lib/ssl/openssl.cnf
expenv COUNTRY /usr/lib/ssl/openssl.cnf
expenv REGION /usr/lib/ssl/openssl.cnf
expenv CITY /usr/lib/ssl/openssl.cnf
expenv ORG /usr/lib/ssl/openssl.cnf
