# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/ca .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/ca/env
	ln -f "$(shell pwd)/openssl.cnf"		/config/ca/openssl.cnf
	ln -f "$(shell pwd)/restart.txt" 		/config/ca/restart.txt
	ln -f "$(shell pwd)/nginx.ca.conf"	/config/nginx/nginx.ca.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name ca                                                          			\
	--env DOMAIN="$(DOMAIN)"   						 			 		      					  			\
	--env CA_NAME="$(CA_NAME)"   			 			 		      					  					\
	--publish 11443:11443                                                   \
	--publish 11180:11180                                                   \
	--publish 11188:11188                                                   \
	--volume /config/ca:/config       			                       		  		\
	suderman/ca

# Create a new interactive container from the image
shell: 
	docker run													\
	--rm -it														\
	--env DOMAIN="$(DOMAIN)"			  		\
	--env CA_NAME="$(CA_NAME)"  				\
	--volume /data:/data								\
	--publish 11443:11443               \
	--publish 11180:11180               \
	--publish 11188:11188               \
	--volume /config/ca:/config      		\
	suderman/ca /bin/bash
