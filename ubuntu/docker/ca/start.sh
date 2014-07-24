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
CA_NAME=`getenv CA_NAME 'Certificate Authority'`
COUNTRY=`getenv COUNTRY $(curl -s ipinfo.io/country)`
REGION=`getenv REGION $(curl -s ipinfo.io/region)`
CITY=`getenv CITY $(curl -s ipinfo.io/city)`
ORG="ca.$DOMAIN CA"


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# openssl
cp -f /config/openssl.cnf /usr/lib/ssl/openssl.cnf
expenv DOMAIN /usr/lib/ssl/openssl.cnf
expenv CA_NAME /usr/lib/ssl/openssl.cnf
expenv COUNTRY /usr/lib/ssl/openssl.cnf
expenv REGION /usr/lib/ssl/openssl.cnf
expenv CITY /usr/lib/ssl/openssl.cnf
expenv ORG /usr/lib/ssl/openssl.cnf


# -------------------------------------------
# Initial set-up for this container
# -------------------------------------------

# Create directory structure
mkdir -p /config/ca
mkdir -p /config/db
mkdir -p /config/crl
mkdir -p /config/ocsp
mkdir -p /config/certs
mkdir -p /config/newcerts
mkdir -p /config/responses

# Flat file database
[ -f /config/db/index ] || touch /config/db/index
[ -f /config/db/serial ] || echo 1000 > /config/db/serial
[ -f /config/crl/crlnumber ] || echo 1000 > /config/crl/crlnumber


# -------------------------------------------
# CA Certificate
# -------------------------------------------

# Certificate variables
UNIT="Certificate Authority"
NAME="$CA_NAME"
EMAIL="ca@$DOMAIN"

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


# -------------------------------------------
# OCSP Responder
# -------------------------------------------

# Certificate variables
UNIT="Certificate Authority OCSP"
NAME="$CA_NAME OCSP"
EMAIL="ocsp@$DOMAIN"

# Generate the OCSP key (ocsp.key)
[ -f /config/ocsp/ocsp.key ] || 
openssl genrsa -out /config/ocsp/ocsp.key 2048
chmod 400 /config/ocsp/ocsp.key

# Generate the OCSP certificate signing request (ocsp.csr)
[ -f /config/ocsp/ocsp.crt ] || 
openssl req -new -extensions v3_OCSP                                                    \
  -subj "/C=$COUNTRY/ST=$REGION/L=$CITY/O=$ORG/OU=$UNIT/CN=$NAME/emailAddress=$EMAIL/"  \
  -key /config/ocsp/ocsp.key                                                            \
  -out /config/ocsp/ocsp.csr 

# Sign the request and create the certificate (ocsp.crt)
[ -f /config/ocsp/ocsp.crt ] || 
yes | openssl ca -notext -md sha1 -days 3650 -extensions v3_OCSP                        \
  -keyfile /config/ca/ca.key                                                            \
  -cert    /config/ca/ca.crt                                                            \
  -in      /config/ocsp/ocsp.csr                                                        \
  -out     /config/ocsp/ocsp.crt 
chmod 444  /config/ocsp/ocsp.crt
rm -f /config/ocsp/ocsp.csr


# -------------------------------------------
# Certificate Revocation List
# -------------------------------------------

# Regenerate the certificate revocation list
openssl ca -gencrl                                                                      \
  -keyfile  /config/ca/ca.key                                                           \
  -cert     /config/ca/ca.crt                                                           \
  -out      /config/crl/ca.crl.pem
openssl crl                                                                             \
  -inform   PEM                                                                         \
  -outform  DER                                                                         \
  -in       /config/crl/ca.crl.pem                                                      \
  -out      /config/crl/ca.crl


# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Start the node server
cd /ca && npm start

