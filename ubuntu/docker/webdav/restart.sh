#!/bin/bash

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Write the env variables if set
[ -z "$WEBDAV_USER" ] || echo $WEBDAV_USER > /config/webdav_user.txt
[ -z "$WEBDAV_PASS" ] || echo $WEBDAV_PASS > /config/webdav_pass.txt
$WEBDAV_USER=$(cat /config/webdav_user.txt)
$WEBDAV_PASS=$(cat /config/webdav_pass.txt)

# Copy config files to where they're expected
cp -f /config/webdav.conf /etc/apache2/sites-available/000-default.conf
sed -i.bak "s/\$WEBDAV_USER/$WEBDAV_USER/g" /etc/apache2/sites-available/000-default.conf


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart services
/usr/sbin/service apache2 restart
