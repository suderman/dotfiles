# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/plex .

# Make host configuration directory
config:
	mkdir -p /data/config/plex
	mkdir -p /data/{media,downloads}

# Create a new detached container from the image
container: 
	docker run                                           \
	--detach                                             \
	--name plex                                          \
	--net host                                           \
	--volume /data/config/plex:/config                   \
	--volume /data/media:/media                          \
	--volume /data/downloads:/downloads                  \
	suderman/plex
