#!/bin/bash

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/my.cnf /etc/mysql/my.cnf


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart services
/usr/sbin/service mysql restart
