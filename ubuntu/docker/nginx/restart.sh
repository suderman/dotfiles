#!/bin/sh

# -------------------------------------------
# Set environment variables
# -------------------------------------------

# Write the env variable to disk if set; load from disk; set default if blank
[ -z "$DOMAIN" ] || echo $DOMAIN > /config/domain.txt
DOMAIN=$(cat /config/domain.txt)
[ -z "$DOMAIN" ] && DOMAIN="local"


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/nginx.conf          /etc/nginx/sites-enabled/nginx.conf
sed -i.bak "s/\$DOMAIN/$DOMAIN/g" /etc/nginx/sites-enabled/nginx.conf
rm /etc/nginx/sites-enabled/nginx.conf.bak


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart services
/usr/sbin/nginx -s reload
