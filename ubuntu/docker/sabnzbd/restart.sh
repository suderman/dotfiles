#!/bin/sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
# (none)


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Kill services
pkill sabnzbdplus
sleep 1

# Restart services
/usr/bin/sabnzbdplus        \
  --daemon                  \
  --config-file /config     \
  --server :8080
