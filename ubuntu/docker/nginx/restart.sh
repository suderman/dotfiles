#!/bin/sh

# Reload config
/config.sh

# Restart services
/usr/sbin/nginx -s reload
