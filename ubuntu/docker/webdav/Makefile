# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/webdav .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/webdav
	ln -f "$(shell pwd)/webdav.conf"  /config/webdav/webdav.conf
	ln -f "$(shell pwd)/restart.txt" /config/webdav/restart.txt

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name webdav                                                           \
	--env WEBDAV_USER="$(WEBDAV_USER)"        			 			 		   					  \
	--env WEBDAV_PASS="$(WEBDAV_PASS)"        			 			 		   					  \
	--publish 8800:80                                                       \
	--volume /config/webdav:/config        			                       		  \
	suderman/webdav
