#!/bin/bash

# Build
docker build -t="suderman/data" .

# Create container
docker run --name DATA suderman/data

# Backup
docker run -rm --volumes-from DATA -v $(pwd):/backup busybox tar cvf /backup/backup.tar /data

# Restore
docker run -rm --volumes-from CONTAINER_NAME -v $(pwd):/backup busybox tar xvf /backup/backup.tar 

