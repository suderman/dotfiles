# 2015 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/homemaker .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
config:
	mkdir -p /config/homemaker
	ln -f "$(shell pwd)/nginx.homemaker.conf"	/config/nginx/nginx.homemaker.conf

# Create a new detached container from the image
container: 
	docker run                                  \
	--detach                                    \
	--name homemaker                            \
	--hostname homemaker                        \
	--env DB_HOST="$(HOST_IP)"            		  \
	--env DB_USER="$(MARIADB_USER)"        		  \
	--env DB_PASS="$(MARIADB_PASS)"        		  \
	--publish 7000:7000                         \
	--publish 7001:7001                         \
	--volume /config/homemaker:/config          \
	suderman/homemaker

# Create a new interactive container from the image
shell: 
	docker run													        \
	--rm -it														        \
	--env DB_HOST="$(HOST_IP)"           			  \
	--env DB_USER="$(MARIADB_USER)"      			  \
	--env DB_PASS="$(MARIADB_PASS)"      			  \
	--publish 7000:7000                         \
	--publish 7001:7001                         \
	--volume /config/homemaker:/config          \
	suderman/homemaker /bin/bash

