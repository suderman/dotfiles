#!/bin/bash
source /config.sh

# Restart services
pkill -HUP node
cd /ca && npm start
