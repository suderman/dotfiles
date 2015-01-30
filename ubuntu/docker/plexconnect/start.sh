#!/bin/bash
source /helper.sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
# /usr/sbin/incrond

# Start sshd
/usr/sbin/sshd


# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# Copy config files to where they're expected
touch /config/Settings.cfg && ln -sf /config/Settings.cfg /PlexConnect/Settings.cfg


# -------------------------------------------
# Start this container's services                                  :
# -------------------------------------------

# Get the server key & pem, and the ca crt & crl
curl "$CA_SERVER/trailers.apple.com.key" > /nginx/trailers.apple.com.key
curl "$CA_SERVER/trailers.apple.com.pem" > /nginx/trailers.apple.com.pem
curl "$CA_SERVER/trailers.apple.com.crt" > /nginx/trailers.apple.com.crt
chmod 600 /nginx/trailers.apple.com.key /nginx/trailers.apple.com.pem

# Check for updates
cd /PlexConnect && /usr/bin/git pull

# Start the service
/usr/bin/python /PlexConnect/PlexConnect.py
