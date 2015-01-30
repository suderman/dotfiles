#!/bin/bash
source /helper.sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
# (none)

# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Kill services
pkill python
sleep 1

# Restart services
/usr/bin/python /PlexConnect/PlexConnect.py
