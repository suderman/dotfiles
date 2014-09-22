# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/sabnzbd .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/sabnzbd
	ln -f "$(shell pwd)/restart.txt" /config/sabnzbd/restart.txt
	ln -f "$(shell pwd)/nginx.sabnzbd.conf"	/config/nginx/nginx.sabnzbd.conf

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
	--volume /data/library:/library                                         \
	suderman/sabnzbd
