# 2014 Jon Suderman
# https://github.com/suderman/local
all:
	@echo "image config container"

# Build the image from the Dockerfile
image:
	docker build --tag suderman/dnsmasq .

# Make host configuration directory
# - Hardlink config files so changes can be made from this directory
# - dnsmasq will reload when file changes are detected
config:
	mkdir -p /data/config/dnsmasq
	ln -f "$(shell pwd)/hosts" /config/dnsmasq/hosts
	ln -f "$(shell pwd)/hosts.dhcp" /config/dnsmasq/hosts.dhcp
	ln -f "$(shell pwd)/ethers" /config/dnsmasq/ethers
	ln -f "$(shell pwd)/dnsmasq.conf" /config/dnsmasq/dnsmasq.conf
	# ln -f "$(shell pwd)/dnsmasq.block.conf" /data/config/dnsmasq/dnsmasq.block.conf

# Create a new detached container from the image
container: 
	docker run                                                              \
	--detach                                                                \
	--name dnsmasq                        									                \
	--net host 										                                          \
	--publish 53:53 																			             			\
	--publish 53:53/udp              																				\
	--volume /config/dnsmasq:/config       			                       		  \
	suderman/dnsmasq

shell: 
	docker run                                                              \
	--rm -it																																\
	--net host 										                                          \
	--publish 53:53 																			             			\
	--publish 53:53/udp              																				\
	--volume /config/dnsmasq:/config       			                       		  \
	suderman/dnsmasq /bin/bash
