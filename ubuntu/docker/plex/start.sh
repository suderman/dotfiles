#!/bin/sh

rm -f "/config/Library/Application Support/Plex Media Server/plexmediaserver.pid"

HOME=/config start_pms &
sleep 5

tail -f /config/Library/Application\ Support/Plex\ Media\ Server/Logs/**/*.log
