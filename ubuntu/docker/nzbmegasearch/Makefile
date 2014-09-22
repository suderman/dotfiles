# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/nzbmegasearch .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/nzbmegasearch
	ln -f "$(shell pwd)/restart.txt" /config/nzbmegasearch/restart.txt
	ln -f "$(shell pwd)/nginx.nzbmegasearch.conf"	/config/nginx/nginx.nzbmegasearch.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name nzbmegasearch                                                    \
	--hostname nzbmegasearch                                                \
	--publish 5000:5000                                                    	\
	--volume /config/nzbmegasearch:/config                                  \
	suderman/nzbmegasearch

# Create a new interactive container from the image
shell: 
	docker run																															\
	--rm -it																																\
	--publish 5000:5000                                                    	\
	--volume /config/nzbmegasearch:/config                                  \
	suderman/nzbmegasearch /bin/bash
