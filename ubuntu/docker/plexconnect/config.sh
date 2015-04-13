#!/bin/bash
source /helper.sh

# Set environment variables
CA_SERVER=`getenv CA_SERVER localhost`

# Copy config files to where they're expected
touch /config/Settings.cfg && ln -sf /config/Settings.cfg /PlexConnect/Settings.cfg

# Keep ATVSettings saved in /config
touch /config/ATVSettings.cfg && ln -sf /config/ATVSettings.cfg /PlexConnect/ATVSettings.cfg

# Get the trailers.apple.com key & pem, for nginx
curl "$CA_SERVER/trailers.apple.com.key" > /nginx/trailers.apple.com.key
curl "$CA_SERVER/trailers.apple.com.pem" > /nginx/trailers.apple.com.pem
chmod 600 /nginx/trailers.apple.com.key /nginx/trailers.apple.com.pem

# Check for updates
cd /PlexConnect && /usr/bin/git pull
