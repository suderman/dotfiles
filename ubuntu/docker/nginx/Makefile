# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/nginx .

# Make host configuration directory
config:
	mkdir -p /config/nginx
	ln -f "$(shell pwd)/nginx.conf" /config/nginx/nginx.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name nginx                                                            \
	--publish 80:80                                                         \
	--publish 8000:8000                                                     \
	--publish 443:443                                                       \
	--volume /config/nginx:/config        			                       		  \
	suderman/nginx

# docker run -it --rm -p 80:80 -p 8000:8000 -p 443:443 -v /data/config/nginx:/config suderman/nginx /bin/bash
# docker run -it --rm --net host -v /data/config/nginx:/config suderman/nginx /bin/bash
