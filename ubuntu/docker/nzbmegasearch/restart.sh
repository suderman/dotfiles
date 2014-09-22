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
pkill python
sleep 1

# Restart services
/usr/bin/python /usntssearch/NZBmegasearch mega2.py
