#!/bin/bash
source /config.sh

# Start the service
/usr/bin/python /PlexConnect/PlexConnect.py &

# Watch the log and keep the container alive
touch /PlexConnect/PlexConnect.log
tail -F /PlexConnect/PlexConnect.log
