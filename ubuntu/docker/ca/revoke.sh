#!/bin/bash
source /helper.sh

# -------------------------------------------
# Revoke Certificate
# -------------------------------------------
NAME="$1"

# Make sure certificate exists
if grep '^V.*'`printf '%q' "/CN=$NAME/"` /config/db/index; then

  # Revoke the certificate
  openssl ca                                                                              \
    -revoke   "/config/certs/$NAME/$NAME.crt"                                             \
    -keyfile  /config/ca/ca.key                                                           \
    -cert     /config/ca/ca.crt

  # Regenerate the certificate revocation list
  openssl ca -gencrl                                                                      \
    -keyfile  /config/ca/ca.key                                                           \
    -cert     /config/ca/ca.crt                                                           \
    -out      /config/crl/ca.crl
  openssl crl                                                                             \
    -inform   PEM                                                                         \
    -outform  DER                                                                         \
    -in       /config/crl/ca.crl.pem                                                      \
    -out      /config/crl/ca.crl

else
  echo "Revoke issue: $NAME doesn't exist."
fi

# Remove all key/cert files
rm -rf  "/config/certs/$NAME"
