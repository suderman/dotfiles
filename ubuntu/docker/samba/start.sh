#!/bin/sh

# Copy config files to where they're expected
/config.sh

# Start incrond to watch for file changes in /config
/usr/sbin/incrond

# Start up this
/usr/sbin/service avahi-daemon start

# Start up that
/usr/sbin/service samba start

tail -f /var/log/samba/log.*
