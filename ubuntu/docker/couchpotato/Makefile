# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/couchpotato .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/couchpotato
	ln -f "$(shell pwd)/restart.txt" /config/nzbget/restart.txt
	ln -f "$(shell pwd)/nginx.couchpotato.conf"	/config/nginx/nginx.couchpotato.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name couchpotato                                                      \
	--hostname couchpotato                                                  \
	--publish 5050:5050                                                     \
	--volume /config/couchpotato:/config                                    \
	--volume /data/downloads/usenet:/downloads                              \
	--volume /data/library/movies:/movies                                   \
	suderman/couchpotato

# Create a new interactive container from the image
shell: 
	docker run													        \
	--rm -it														        \
	--publish 5050:5050                         \
	--volume /config/couchpotato:/config        \
	--volume /data/downloads/usenet:/downloads  \
	--volume /data/library/movies:/movies       \
	suderman/couchpotato /bin/bash

