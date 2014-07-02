#!/bin/bash

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/webdav.conf /etc/apache2/sites-available/000-default.conf


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart services
/usr/sbin/service apache2 restart
