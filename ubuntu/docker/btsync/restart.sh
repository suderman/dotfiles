#!/bin/bash
source /config.sh

# Kill services
pkill btsync

# Restart services
/usr/bin/btsync --config /config/btsync.conf
