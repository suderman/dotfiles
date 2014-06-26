#!/bin/sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
/usr/sbin/incrond

# Start sshd
/usr/sbin/sshd


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
cp -f /config/owncloud.conf /etc/apache2/sites-enabled/000-default.conf


# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Start the service
/usr/sbin/apache2ctl start

# Tail the logs and keep the container alive
sleep 3
tail -F /var/log/apache2/*.log
