#!/bin/sh

# Link vhosts file to where it's expected
ln -sf /config/vhosts /etc/nginx/sites-enabled/vhosts

# Start incrond to watch for file changes
/usr/sbin/incrond

# Start it up
/usr/sbin/nginx

# Watch the log and keep the container alive
tail -F /var/log/nginx/*
