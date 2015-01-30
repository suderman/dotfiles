# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/plexconnect .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/plexconnect
	ln -f "$(shell pwd)/restart.txt" 						/config/plexconnect/restart.txt
	ln -f "$(shell pwd)/Settings.cfg"  					/config/plexconnect/Settings.cfg
	ln -f "$(shell pwd)/nginx.plexconnect.conf"	/config/nginx/nginx.plexconnect.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name plexconnect           	                                          \
	--publish 10443:10443             																		  \
	--publish 10080:10080	             																		  \
	--env CA_SERVER="$(CA_SERVER)" 							 		      					  			\
	--volume /config/plexconnect:/config   	                       		  		\
	--volume /config/nginx:/nginx   	                            		  		\
	suderman/plexconnect

# Create a new interactive container from the image
shell: 
	docker run														\
	--rm -it															\
	--net host	 	  										  \
	--publish 10443:10443  		           	\
	--publish 10080:10080		            	\
	--env CA_SERVER="$(CA_SERVER)"  			\
	--volume /config/plexconnect:/config 	\
	--volume /config/nginx:/nginx   	 		\
	suderman/plexconnect /bin/bash

