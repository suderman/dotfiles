#!/bin/sh

# Start incrond to watch for file changes
/usr/sbin/incrond

# Start it up
/usr/sbin/nginx

# Watch the log and keep the container alive
tail -F /var/log/nginx/*
