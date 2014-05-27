all: 
	echo "---> image config container clean clean-image push pull"

image:	
	docker build --tag suderman/dnsmasq .

config:
	mkdir -p /config/dnsmasq
	ln -f "$(shell pwd)/hosts" /config/dnsmasq/hosts
	ln -f "$(shell pwd)/ethers" /config/dnsmasq/ethers
	ln -f "$(shell pwd)/dnsmasq.conf" /config/dnsmasq/dnsmasq.conf

container: 
	docker run                                           \
	--detach                                             \
	--name dnsmasq                                       \
  --net host                                           \
	--volume /config/dnsmasq:/config                     \
	suderman/dnsmasq

clean:
	docker stop dnsmasq
	docker rm dnsmasq

clean-image: 
	docker rmi suderman/dnsmasq

push:
	docker push suderman/dnsmasq

pull:
	docker pull suderman/dnsmasq

