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
pkill btsync

# Restart services
/usr/bin/btsync --config /config/btsync.conf
