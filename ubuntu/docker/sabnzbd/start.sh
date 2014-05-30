#!/bin/sh

/usr/bin/sabnzbdplus        \
  --daemon                  \
  --config-file /config     \
  --server :8080

sleep 5
tail -f /config/logs/sabnzbd.*
