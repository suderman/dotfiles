# 2015 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/webdav .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
config:
	mkdir -p /config/webdav/theme
	ln -f "$(shell pwd)/webdav.conf" 				/config/webdav/webdav.conf
	ln -f "$(shell pwd)/style.css"   				/config/webdav/theme/style.css
	ln -f "$(shell pwd)/header.html" 				/config/webdav/theme/header.html
	ln -f "$(shell pwd)/footer.html" 				/config/webdav/theme/footer.html
	ln -f "$(shell pwd)/nginx.webdav.conf"	/config/nginx/nginx.webdav.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name webdav                                                           \
	--env WEBDAV_USER="$(WEBDAV_USER)"        			 			 		   					  \
	--env WEBDAV_PASS="$(WEBDAV_PASS)"        			 			 		   					  \
	--publish 8800:80                                                       \
	--volume /config/webdav:/config        			                       		  \
	--volume /data:/data        			 			                      		 		  \
	suderman/webdav
