#!/bin/bash

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
cp -f /config/webdav.conf /etc/apache2/sites-available/000-default.conf
sed -i.bak "s/\$WEBDAV_USER/$WEBDAV_USER/g" /etc/apache2/sites-available/000-default.conf

# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Make sure webdav folder perms are right
chown data:data /data
chown data:data /var/lock/apache2


# Change apache user from www-data to data
sed -i.bak "s/www-data/data/g" /etc/apache2/envvars

# Created files 664; Created directors 775
grep -q 'umask 002' /etc/apache2/envvars || echo 'umask 002' >> /etc/apache2/envvars

# Set a password and permissions on the file
rm -rf /etc/apache2/webdav.password
htpasswd -cb /etc/apache2/webdav.password $WEBDAV_USER $WEBDAV_PASS
chown data:data /etc/apache2/webdav.password
chmod 640 /etc/apache2/webdav.password

# Start the service
/usr/sbin/service apache2 start

# Tail the logs and keep the container alive
tail -F /var/log/apache2/*.log
