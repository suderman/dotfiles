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
rm -rf /PlexConnect/assets/certificates && ln -sf /config/certificates /PlexConnect/assets/


# -------------------------------------------
# Start this container's services                                  :
# -------------------------------------------

# Generate the certificate needed
cd /config/certificates
(has trailers.pem) || openssl req -new -nodes -newkey rsa:2048 -out trailers.pem -keyout trailers.key -x509 -days 7300 -subj "/C=US/CN=trailers.apple.com"
(has trailers.cer) || openssl x509 -in trailers.pem -outform der -out trailers.cer && cat trailers.key >> trailers.pem

# Check for updates
cd /PlexConnect && /usr/bin/git pull

# Start the service
/usr/bin/python /PlexConnect/PlexConnect.py
