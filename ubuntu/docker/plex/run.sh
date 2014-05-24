#!/bin/sh

# 2014 Jon Suderman
# https://github.com/suderman/local

# Build
if [ -z "$(docker images --quiet suderman/plex)" ]; then
  docker build -t="suderman/plex" .
fi

# Server
docker run                        \
  --detach                        \
  --name plex                     \
  --net host                      \
  --volume /data/plex:/config     \
  --volume /data/media:/media     \
  suderman/plex

