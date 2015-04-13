#!/bin/bash
source /config.sh

# Clean-up
rm -f "$PMS/plexmediaserver.pid"

# Start the service
HOME=/config start_pms &
sleep 5

# Tail the logs and keep the container alive
tail -F "$PMS/Logs/Plex Media Server.log"
