#!/bin/sh

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
touch /config/custom_params.ini
ln -sf /config/custom_params.ini /usntssearch/NZBmegasearch/custom_params.ini


# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Start the service
/usr/bin/python /usntssearch/NZBmegasearch/mega2.py
