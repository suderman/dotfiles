#!/bin/bash
source /helper.sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
# (none)


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Kill services
pkill python
sleep 5

# Restart services
/usr/bin/python /CouchPotatoServer/CouchPotato.py   \
  --daemon                                          \
  --console_log                                     \
  --data_dir    /config                             \
  --config_file /config/settings.conf

