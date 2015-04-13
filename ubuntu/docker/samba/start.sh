#!/bin/bash
source /config.sh

# Start the services
/usr/sbin/service avahi-daemon start
/usr/sbin/service samba start
/usr/sbin/service nmbd start

# Tail the logs and keep the container alive
tail -F /var/log/samba/log.*
