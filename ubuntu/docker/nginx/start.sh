#!/bin/bash
source /config.sh

# Start the service
/usr/sbin/nginx

# Tail the logs and keep the container alive
tail -F /var/log/nginx/*
