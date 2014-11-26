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

# Install UnSupported Appstore
# rm -f unzip /tmp/master.zip
# rm -f "/config/Library/Application Support/Plex Media Server/Plug-ins/UnSupportedAppstore.bundle"
# cd /tmp
# wget https://github.com/mikedm139/UnSupportedAppstore.bundle/archive/master.zip
# unzip /tmp/master.zip
# mv /tmp/UnSupportedAppstore.bundle-master "/config/Library/Application Support/Plex Media Server/Plug-ins/UnSupportedAppstore.bundle"

# Clean-up
rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

# Start the service
HOME=/config start_pms &
sleep 5

# Tail the logs and keep the container alive
tail -F /config/Library/Application\ Support/Plex\ Media\ Server/Logs/Plex\ Media\ Server.log
# tail -F /config/Library/Application\ Support/Plex\ Media\ Server/Logs/**/*.log

