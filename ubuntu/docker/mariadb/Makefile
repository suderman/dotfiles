# 2014 Jon Suderman
# https://github.com/suderman/local
all: 
	@echo "image config container"

# Build the image from the Dockerfile
image:	
	docker build --tag suderman/mariadb .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when restart.txt is touched
config:
	mkdir -p /config/mariadb/mysql
	ln -f "$(shell pwd)/my.cnf" 			/config/mariadb/my.cnf
	ln -f "$(shell pwd)/restart.txt" 	/config/mariadb/restart.txt

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name mariadb                                                          \
	--env DB_USER="$(MARIADB_USER)"        			 			 		      					  \
	--env DB_PASS="$(MARIADB_PASS)"        			 			 		      					  \
	--publish 3306:3306                                                     \
	--volume /config/mariadb:/config       			                       		  \
	suderman/mariadb

# docker run --rm -it -p 3306:3306 -v /config/mariadb:/config -v suderman/mariadb /bin/bash
