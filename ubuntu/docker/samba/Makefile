# 2014 Jon Suderman
# https://github.com/suderman/local
all:
	@echo "image config user container"

# Build the image from the Dockerfile
image:
	docker build --tag suderman/samba .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - daemon will reload when file changes are detected
config:
	mkdir -p /data/config/samba
	ln -f "$(shell pwd)/smb.conf" /data/config/samba/smb.conf
	ln -f "$(shell pwd)/samba.service" /data/config/samba/samba.service
	ln -f "$(shell pwd)/avahi-daemon.conf" /data/config/samba/avahi-daemon.conf

# Make host user/group for shared volume
user:
	sudo useradd --home-dir / --shell /bin/bash data
	sudo usermod -p data data && usermod -U data
	sudo usermod -u 2000 data && groupmod -g 2000 data
	sudo gpasswd -a ${USER} data

# Create a new detached container from the image
container: 
	docker run                                           \
	--detach                                             \
	--name samba                                         \
	--net host                                           \
	--volume /data/config/samba:/config                  \
	--volume /data/media:/media                          \
	--volume /data/downloads:/downloads                  \
	suderman/samba

# docker run -it --rm --net host -v /data/config/samba:/config -v /data/media:/media -v /data/downloads:/downloads suderman/samba /bin/bash
