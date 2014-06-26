#!/bin/sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/owncloud.conf /etc/apache2/sites-enabled/000-default.conf


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart the service
/usr/sbin/apache2ctl restart
