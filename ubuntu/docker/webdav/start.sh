#!/bin/bash
source /config.sh

# Start the service
/usr/sbin/service apache2 start

# Tail the logs and keep the container alive
tail -F /var/log/apache2/error.log
