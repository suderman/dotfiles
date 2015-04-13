# 2015 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/plex .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
config:
	mkdir -p /config/plex
	mkdir -p /data/library
	mkdir -p /data/media/videos
	ln -f "$(shell pwd)/nginx.plex.conf"	/config/nginx/nginx.plex.conf

# Create a new detached container from the image
container: 
	docker run                                   \
	--detach                                     \
	--name plex                                  \
	--net host																	 \
	--volume /config/plex:/config  			         \
	--volume /data/library:/library              \
	--volume /data/media:/media         		     \
	suderman/plex

# Create a new interactive container from the image
shell: 
	docker run													            \
	--rm -it														            \
	--volume /config/plex:/config  	                \
	--volume /data/library:/library                 \
	--volume /data/media:/media                     \
	suderman/plex /bin/bash
