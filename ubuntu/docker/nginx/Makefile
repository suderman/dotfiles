# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/nginx .

# Make host configuration directory
config:
	mkdir -p /data/config/nginx/{sites-available,sites-enabled}

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name nginx                                                            \
	--publish 80:80                                                         \
	--publish 8000:8000                                                     \
	--publish 443:443                                                       \
	--volume /data/config/nginx/sites-available:/etc/nginx/sites-available  \
	--volume /data/config/nginx/sites-enabled:/etc/nginx/sites-enabled      \
	suderman/nginx
