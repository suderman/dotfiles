# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/nginx .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/nginx
	ln -f "$(shell pwd)/nginx.conf"  /config/nginx/nginx.conf
	ln -f "$(shell pwd)/restart.txt" /config/nginx/restart.txt

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name nginx                                                            \
	--publish 80:80                                                         \
	--publish 8000:8000                                                     \
	--publish 443:443                                                       \
	--env DOMAIN="$(DOMAIN)"        			 			 		      					  			\
	--env HOST_IP="$(HOST_IP)"       			 			 		      					  			\
	--env GATEWAY_IP="$(GATEWAY_IP)" 			 			 		      					  			\
	--env CA_SERVER="$(CA_SERVER)" 							 		      					  			\
	--volume /data/public:/public        			                        		  \
	--volume /config/nginx:/config        			                       		  \
	suderman/nginx

shell: 
	docker run                                                              \
	--rm -it																																\
	--publish 80:80                                                         \
	--publish 8000:8000                                                     \
	--publish 443:443                                                       \
	--env DOMAIN="$(DOMAIN)"        			 			 		      					  			\
	--env HOST_IP="$(HOST_IP)"       			 			 		      					  			\
	--env GATEWAY_IP="$(GATEWAY_IP)" 			 			 		      					  			\
	--env CA_SERVER="$(CA_SERVER)" 							 		      					  			\
	--volume /data/public:/public        			                        		  \
	--volume /config/nginx:/config        			                       		  \
	suderman/nginx /bin/bash

# docker run -it --rm -p 80:80 -p 8000:8000 -p 443:443 -v /data/config/nginx:/config suderman/nginx /bin/bash
# docker run -it --rm --net host -v /data/config/nginx:/config suderman/nginx /bin/bash
