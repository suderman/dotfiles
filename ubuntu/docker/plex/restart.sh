#!/bin/bash
source /config.sh

# Trying to kill the Plex Media Server itself but also the Plug-ins
pkill start_pms
pkill Plex
sleep 1

# Clean-up
rm -f "$PMS/plexmediaserver.pid"

# Restart services
HOME=/config /usr/sbin/start_pms &
sleep 5
