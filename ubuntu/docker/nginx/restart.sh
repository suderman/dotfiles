#!/bin/bash
source /config.sh

# Restart services
/usr/sbin/nginx -s reload
