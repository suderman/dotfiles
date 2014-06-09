# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/sabnzbd .

# Make host configuration directory
config:
	mkdir -p /config/sabnzbd

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name sabnzbd                                                          \
	--hostname sabnzbd                                                      \
	--publish 8080:8080                                                     \
	--publish 9090:9090                                                     \
	--volume /config/sabnzbd:/config                                        \
	--volume /data/downloads/usenet:/downloads                              \
	--volume /data/movies:/movies                                           \
	--volume /data/shows:/shows 	                                          \
	--volume /data/music:/music 	                                          \
	suderman/sabnzbd
