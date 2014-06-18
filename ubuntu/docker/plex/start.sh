#!/bin/sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
/usr/sbin/incrond

# Start sshd
/usr/sbin/sshd


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
# (none)


# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Clean-up
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

# Start the service
HOME=/config start_pms &
sleep 5

# Tail the logs and keep the container alive
tail -F /config/Library/Application\ Support/Plex\ Media\ Server/Logs/**/*.log
