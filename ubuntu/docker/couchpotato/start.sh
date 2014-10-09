#!/bin/bash
source /helper.sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
# /usr/sbin/incrond

# Start sshd
/usr/sbin/sshd


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected


# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Start the service
/usr/bin/python /CouchPotatoServer/CouchPotato.py   \
  --daemon                                          \
  --console_log                                     \
  --data_dir    /config                             \
  --config_file /config/settings.conf

# Tail the logs to keep the container alive
tail -F /config/logs/*
