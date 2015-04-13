#!/bin/bash
source /config.sh

# Start it up
/usr/sbin/dnsmasq

# Watch the log and keep the container alive
touch /dnsmasq.log
tail -f /dnsmasq.log
