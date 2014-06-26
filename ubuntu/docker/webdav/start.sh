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
cp -f /config/webdav.conf /etc/apache2/sites-enabled/000-default.conf


# -------------------------------------------
# Start this container's services
# -------------------------------------------

# make sure webdav folder perms are right
chown data:data /data
chown data:data /var/lock/apache2

# # Insert webdav apache conf
# # conf_file="/etc/apache2/sites-enabled/default-ssl.conf"
# conf_file="/etc/apache2/sites-enabled/default.conf"
# str_find="<\/VirtualHost>"
# str_replace="\x0a  Include \/config\/webdav.conf\x0a<\/VirtualHost>"
# grep -q 'Include /config/webdav.conf' $conf_file || sed -i.bak "s/$str_find/$str_replace/g" $conf_file

# # Generate a new key and cert                                   
# openssl req -new -newkey rsa:1024 -days 365 -nodes -x509 \
#     -subj "/C=XX/ST=XX/L=XX/O=XX/CN=XX" \
#     -keyout /etc/ssl/private/ssl-cert-snakeoil.key \
#     -out /etc/ssl/certs/ssl-cert-snakeoil.pem

# Set a password and permissions on the file
rm -rf /etc/apache2/webdav.password
htpasswd -cb /etc/apache2/webdav.password webdav $WEBDAV_PASS
chown data:data /etc/apache2/webdav.password
chmod 640 /etc/apache2/webdav.password

# Start the service
/usr/sbin/service apache2 start

# Tail the logs and keep the container alive
tail -F /var/log/apache2/*.log
