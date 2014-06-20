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

# Start the service
/usr/bin/btsync --config /config/btsync.conf

# Tail the logs and keep the container alive
tail -f /config/sync/sync.log
