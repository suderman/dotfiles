#!/bin/bash
source /config.sh

# Restart services
/usr/sbin/service samba restart
/usr/sbin/service nmbd restart
/usr/sbin/service avahi-daemon restart
