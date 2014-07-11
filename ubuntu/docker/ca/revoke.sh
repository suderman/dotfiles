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


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/openssl.cnf /usr/lib/ssl/openssl.cnf
expenv CA_DOMAIN /usr/lib/ssl/openssl.cnf
expenv CA_NAME /usr/lib/ssl/openssl.cnf


# -------------------------------------------
# New Certificate
# -------------------------------------------

# Certificate variables
NAME="$1"

# Stop here if it doesn't exists
if ! grep '^V.*'`printf '%q' "/CN=$NAME/"` /config/db/index; then
  echo "Stopped: $NAME doesn't exist."
  exit; 
fi

# Revoke the certificate
openssl ca                                                                              \
  -revoke /config/certs/$NAME/$NAME.crt                                                 \
  -keyfile /config/ca/ca.key                                                            \
  -cert /config/ca/ca.crt

# Remove all key/cert files
rm -rf  /config/certs/$NAME

# Update the certificate revocation list
openssl ca -gencrl                                                                      \
  -keyfile /config/ca/ca.key                                                            \
  -cert /config/ca/ca.crt                                                               \
  -out /config/crl/ca.crl
