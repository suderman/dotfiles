# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/owncloud .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/owncloud
	ln -f "$(shell pwd)/owncloud.conf" 				/config/owncloud/owncloud.conf
	ln -f "$(shell pwd)/restart.txt" 	 				/config/owncloud/restart.txt
	ln -f "$(shell pwd)/nginx.owncloud.conf"	/config/nginx/nginx.owncloud.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name owncloud                                                         \
	--hostname owncloud                                                     \
	--publish 8100:80	                                                      \
	--volume /config/owncloud:/config                                       \
	--volume /data:/data                                                    \
	suderman/owncloud

# docker run --rm -it -p 8100:80 -v /config/owncloud:/config -v /data/public:/data suderman/owncloud /bin/bash
