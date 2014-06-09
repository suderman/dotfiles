# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/plex .

# Make host configuration directory
config:
	mkdir -p /config/plex
	mkdir -p /data/movies
	mkdir -p /data/shows
	mkdir -p /data/media
	mkdir -p /data/personal
	mkdir -p /data/downloads

# Create a new detached container from the image
container: 
	docker run                                           \
	--detach                                             \
	--name plex                                          \
	--net host                                           \
	--volume /config/plex:/config  			                 \
	--volume /data/movies:/movies                        \
	--volume /data/shows:/shows                          \
	--volume /data/music:/music                          \
	--volume /data/media:/media                          \
	--volume /data/personal:/personal                    \
	--volume /data/downloads:/downloads                  \
	suderman/plex
