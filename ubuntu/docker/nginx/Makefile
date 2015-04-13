# 2015 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/nginx .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
config:
	mkdir -p /config/nginx
	ln -f "$(shell pwd)/nginx.conf"  				/config/nginx/nginx.conf
	ln -f "$(shell pwd)/proxy_params.conf"	/config/nginx/proxy_params.conf
	ln -f "$(shell pwd)/verify_client.conf" /config/nginx/verify_client.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name nginx                                                            \
	--publish 80:80                                                         \
	--publish 8000:8000                                                     \
	--publish 443:443                                                       \
	--publish 4430:4430                                                     \
	--env DOMAIN="$(DOMAIN)"        			 			 		      					  			\
	--env HOST_IP="$(HOST_IP)"       			 			 		      					  			\
	--env GATEWAY_IP="$(GATEWAY_IP)" 			 			 		      					  			\
	--env CA_SERVER="$(CA_SERVER)" 							 		      					  			\
	--volume /data/public:/public        			                        		  \
	--volume /data/downloads:/downloads    		                        		  \
	--volume /config/nginx:/config        			                       		  \
	suderman/nginx

shell: 
	docker run                                                              \
	--rm -it																																\
	--publish 80:80                                                         \
	--publish 8000:8000                                                     \
	--publish 443:443                                                       \
	--publish 4430:4430                                                     \
	--env DOMAIN="$(DOMAIN)"        			 			 		      					  			\
	--env HOST_IP="$(HOST_IP)"       			 			 		      					  			\
	--env GATEWAY_IP="$(GATEWAY_IP)" 			 			 		      					  			\
	--env CA_SERVER="$(CA_SERVER)" 							 		      					  			\
	--volume /data/public:/public        			                        		  \
	--volume /data/downloads:/downloads    		                        		  \
	--volume /config/nginx:/config        			                       		  \
	suderman/nginx /bin/bash
