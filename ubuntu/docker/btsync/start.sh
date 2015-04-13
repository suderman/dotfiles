#!/bin/bash
source /config.sh

# Start the service
/usr/bin/btsync --config /config/btsync.conf

# Tail the logs and keep the container alive
tail -f /config/sync/sync.log
