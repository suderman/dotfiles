#!/bin/bash
source /config.sh

# Kill services
pkill python
sleep 1

# Restart services
/usr/bin/python /PlexConnect/PlexConnect.py
