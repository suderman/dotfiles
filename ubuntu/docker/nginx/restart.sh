#!/bin/sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/nginx.conf /etc/nginx/sites-enabled/nginx.conf


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart services
/usr/sbin/nginx -s reload
