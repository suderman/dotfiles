#!/bin/sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/avahi-daemon.conf /etc/avahi/avahi-daemon.conf
cp -f /config/smb.conf          /etc/samba/smb.conf
cp -f /config/samba.service     /etc/avahi/services/samba.service


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart services
/usr/sbin/service samba restart
/usr/sbin/service nmbd restart
/usr/sbin/service avahi-daemon restart
