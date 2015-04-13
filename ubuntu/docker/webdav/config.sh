#!/bin/bash
source /helper.sh

# Copy config files to where they're expected
cp -f /config/webdav.conf /etc/apache2/sites-available/000-default.conf

# Write the env variable to disk if set; load from disk; set default if blank
WEBDAV_USER=`getenv WEBDAV_USER 'data'`
WEBDAV_PASS=`getenv WEBDAV_PASS 'data'`

# # Write the env variable to disk if set; load from disk; set default if blank
# [ -z "$WEBDAV_USER" ] || echo $WEBDAV_USER > /config/webdav_user.txt
# WEBDAV_USER=$(cat /config/webdav_user.txt)
# [ -z "$WEBDAV_USER" ] && WEBDAV_USER="data"
#
# # Write the env variable to disk if set; load from disk; set default if blank
# [ -z "$WEBDAV_PASS" ] || echo $WEBDAV_PASS > /config/webdav_pass.txt
# WEBDAV_PASS=$(cat /config/webdav_pass.txt)
# [ -z "$WEBDAV_PASS" ] && WEBDAV_PASS="data"

# Which user/group this process should run as
APACHE_USER="data"

# envvars - default environment variables for apache2ctl
env="/etc/apache2/envvars"

# Change apache user from www-data to $APACHE_USER
sed -i.bak "s/www-data/$APACHE_USER/g" $env

# Add username and password to apache's envvars
grep -q 'export WEBDAV_USER' $env || echo "export WEBDAV_USER=\"$WEBDAV_USER\"" >> $env
grep -q 'export WEBDAV_PASS' $env || echo "export WEBDAV_PASS=\"$WEBDAV_PASS\"" >> $env

# Created files 664; Created directors 775
grep -q 'umask 002' $env || echo 'umask 002' >> $env

# Make sure webdav folder perms are right
chown $APACHE_USER:$APACHE_USER /data
chown $APACHE_USER:$APACHE_USER /var/lock/apache2

# Set a password and permissions on the file
rm -rf /etc/apache2/webdav.password
htpasswd -cb /etc/apache2/webdav.password $WEBDAV_USER $WEBDAV_PASS
chown $APACHE_USER:$APACHE_USER /etc/apache2/webdav.password
chmod 640 /etc/apache2/webdav.password

# Clone apaxy to config
git clone-pull https://github.com/AdamWhitcroft/Apaxy.git /config/apaxy
