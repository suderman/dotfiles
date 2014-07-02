# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/plex .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/plex
	mkdir -p /data/library
	mkdir -p /data/media/videos
	ln -f "$(shell pwd)/restart.txt" /config/plex/restart.txt

# Create a new detached container from the image
container: 
	docker run                                           \
	--detach                                             \
	--name plex                                          \
	--net host																					 \
	--volume /config/plex:/config  			                 \
	--volume /data/library:/library                      \
	--volume /data/media/videos:/videos                  \
	suderman/plex

# container: 
# 	docker run                                           \
# 	--detach                                             \
# 	--publish 32400:32400                                \
# 	--publish 32443:32443                                \
# 	--publish 1900:1900/udp                              \
# 	--publish 32410:32410/udp                            \
# 	--publish 32412:32412/udp                            \
# 	--publish 32413:32413/udp                            \
# 	--publish 32414:32414/udp                            \
# 	--publish 32469:32469                                \
# 	--volume /config/plex:/config  			                 \
# 	--volume /data/library:/library                      \
# 	--volume /data/media/videos:/videos                  \
# 	suderman/plex
