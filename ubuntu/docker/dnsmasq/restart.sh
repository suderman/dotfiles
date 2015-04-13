#!/bin/bash
source /config.sh

# Restart it
pkill -HUP dnsmasq
