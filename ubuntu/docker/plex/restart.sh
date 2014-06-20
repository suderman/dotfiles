#!/bin/sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
# (none)


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Trying to kill the Plex Media Server itself but also the Plug-ins
pkill start_pms
pkill Plex
sleep 1

# Clean-up
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

# Restart services
HOME=/config /usr/sbin/start_pms &
sleep 5
