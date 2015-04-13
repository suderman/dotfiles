#!/bin/bash
source /config.sh

# Kill services
pkill python
sleep 5

# Restart services
/usr/bin/python /CouchPotatoServer/CouchPotato.py   \
  --daemon                                          \
  --console_log                                     \
  --data_dir    /config                             \
  --config_file /config/settings.conf

