#!/bin/bash
source /config.sh

# Restart services
pkill -HUP node
sleep 3
cd /homemaker && npm run server
