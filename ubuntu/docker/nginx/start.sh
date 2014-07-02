#!/bin/sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
/usr/sbin/incrond

# Start sshd
/usr/sbin/sshd


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
# Start this container's services
# -------------------------------------------

# Generate the RSA private key
[ -f /config/my.key ] || 
openssl genrsa 2048 > /config/my.key

# Generate the signed certificate
[ -f /config/my.cer ] || 
openssl req -new -x509 -nodes -sha1 -days 3650 -subj /CN=*.$DOMAIN/ -key /config/my.key > /config/my.cer

# Generate the info file
[ -f /config/my.info ] || 
openssl x509 -noout -fingerprint -text < /config/my.cer > /config/my.info

# Put it together
[ -f /config/my.pem ] || cat /config/my.cer /config/my.key > /config/my.pem
chmod 600 /config/my.key /config/my.pem


# Start the service
/usr/sbin/nginx

# Tail the logs and keep the container alive
tail -F /var/log/nginx/*
