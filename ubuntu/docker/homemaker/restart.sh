#!/bin/bash
source /helper.sh

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

DB_HOST=`getenv DB_HOST '127.0.0.1'`
DB_USER=`getenv DB_USER 'root'`
DB_PASS=`getenv DB_PASS ''`
DB_PASSWORD=`getenv DB_PASS ''`
DB_NAME='homemaker'
PORT='7000'
API_PORT='7001'


# -------------------------------------------
# Restart this container's services
# -------------------------------------------

# Restart services
pkill -HUP node
sleep 3
cd /homemaker && npm run server
