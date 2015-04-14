#!/bin/bash
source /helper.sh

# Copy config files to where they're expected
PMS="/config/Library/Application Support/Plex Media Server"

# Install UnSupported Appstore
if hasnt "$PMS/Plug-ins/UnSupportedAppstore.bundle"; then
  # wget https://github.com/mikedm139/UnSupportedAppstore.bundle/archive/master.zip -O /tmp/appstore.zip
  wget http://bit.ly/ihqmEu -O /tmp/appstore.zip
  unzip /tmp/master.zip
  mv /tmp/UnSupportedAppstore.bundle "$PMS/Plug-ins/UnSupportedAppstore.bundle"
fi
