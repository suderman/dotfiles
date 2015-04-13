#!/bin/bash
source /config.sh

# Kill services
pkill sabnzbdplus
sleep 1

# Restart services
/usr/bin/sabnzbdplus        \
  --daemon                  \
  --config-file /config     \
  --server :8080
