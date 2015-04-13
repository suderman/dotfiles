#!/bin/bash
source /config.sh

# Start the service
/usr/bin/python /CouchPotatoServer/CouchPotato.py   \
  --daemon                                          \
  --console_log                                     \
  --data_dir    /config                             \
  --config_file /config/settings.conf

# Tail the logs to keep the container alive
tail -F /config/logs/*
