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
# New Certificate
# -------------------------------------------

# Certificate variables
UNIT="Certificate"
NAME="$1"
EMAIL=$(echo $NAME | sed 's/^\*\.//')
EMAIL=$(echo $EMAIL | sed 's/^www\.//')
if [[ $EMAIL != *@* ]]; then EMAIL="contact@$EMAIL"; fi 

# Stop here if it already exists
if grep '^V.*'`printf '%q' "/CN=$NAME/"` /config/db/index; then
  echo "Stopped: $NAME already exists and is valid."
  exit; 
fi

# Create the cert directory and copy the CA certificate (ca.crt)
mkdir -p "/config/certs/$NAME"
cp -f /config/ca/ca.crt "/config/certs/$NAME/ca.crt"

# Generate the private/public key pair ($NAME.key)
openssl genrsa -out "/config/certs/$NAME/$NAME.key" 2048
chmod 600 "/config/certs/$NAME/$NAME.key"

# Extract the public key into its own file ($NAME.pub)
openssl rsa -pubout                                                                     \
  -in "/config/certs/$NAME/$NAME.key"                                                   \
  -out "/config/certs/$NAME/$NAME.pub"

# Create the request ($NAME.csr)
openssl req -new                                                                        \
  -subj "/C=$COUNTRY/ST=$REGION/L=$CITY/O=$ORG/OU=$UNIT/CN=$NAME/emailAddress=$EMAIL/"  \
  -key "/config/certs/$NAME/$NAME.key"                                                  \
  -out "/config/certs/$NAME/$NAME.csr"


# Sign the request and create the certificate ($NAME.crt)
yes | openssl ca -notext -md sha1 -days 3650 -extensions usr_cert                       \
  -keyfile /config/ca/ca.key                                                            \
  -cert    /config/ca/ca.crt                                                            \
  -in      "/config/certs/$NAME/$NAME.csr"                                              \
  -out     "/config/certs/$NAME/$NAME.crt"
chmod 444 "/config/certs/$NAME/$NAME.crt"
rm "/config/certs/$NAME/$NAME.csr"

# Generate a p12 file from everything we just made ($NAME.p12)
openssl pkcs12 -export -password pass:$NAME                                             \
  -certfile /config/ca/ca.crt                                                           \
  -inkey "/config/certs/$NAME/$NAME.key"                                                \
  -in "/config/certs/$NAME/$NAME.crt"                                                   \
  -out "/config/certs/$NAME/$NAME.p12"                           

# Create a zip archive of everything ($NAME.zip)
rm -f  "/config/certs/$NAME/$NAME.zip"
zip -j "/config/certs/$NAME/$NAME.zip" "/config/certs/$NAME/"*

