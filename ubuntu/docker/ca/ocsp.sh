#!/bin/bash

# Create the response file from the request file
openssl ocsp                                            \
  -index   /config/db/index                             \
  -CA      /config/ca/ca.crt                            \
  -CAfile  /config/ca/ca.crt                            \
  -issuer  /config/ca/ca.crt                            \
  -rsigner /config/ocsp/ocsp.crt                        \
  -rkey    /config/ocsp/ocsp.key                        \
  -reqin   "$1.req"                                     \
  -respout "$1"

