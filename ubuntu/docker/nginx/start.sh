#!/bin/sh

# Copy config files to where they're expected
/config.sh

# Start incrond to watch /config/restart.txt
/usr/sbin/incrond

# Start sshd
/usr/sbin/sshd

# Start the service
/usr/sbin/nginx

# Tail the logs and keep the container alive
tail -F /var/log/nginx/*
