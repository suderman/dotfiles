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
	ln -f "$(shell pwd)/start.sh" 	/config/ca/start.sh
	ln -f "$(shell pwd)/new.sh" 		/config/ca/new.sh
	ln -f "$(shell pwd)/revoke.sh"  /config/ca/revoke.sh
	ln -f "$(shell pwd)/openssl.cnf" 	/config/ca/openssl.cnf
	ln -f "$(shell pwd)/restart.txt" 	/config/ca/restart.txt

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name ca                                                          			\
	--env CA_DOMAIN="$(CA_DOMAIN)"   			 			 		      					  			\
	--env CA_NAME="$(CA_NAME)"   			 			 		      					  					\
	--publish 8008:8008                                                     \
	--volume /config/ca:/config       			                       		  		\
	suderman/ca

# Create a new interactive container from the image
shell: 
	docker run													\
	--rm -it														\
	--env CA_DOMAIN="$(CA_DOMAIN)"  		\
	--env CA_NAME="$(CA_NAME)"  				\
	--volume /data:/data								\
	--publish 8008:8008                 \
	--volume /config/ca:/config      		\
	suderman/ca /bin/bash
