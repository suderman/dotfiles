all: 
	echo "---> image container clean clean-image push pull"

image:	
	docker build --tag suderman/trusty .

container: 
	docker run                                           \
	--rm -it                                             \
	--name trusty                                        \
	--volume /config:/config                     				 \
	--volume /data:/data                     				     \
	suderman/trusty /bin/bash

clean:
	docker stop trusty
	docker rm trusty

clean-image: 
	docker rmi suderman/trusty

push:
	docker push suderman/trusty

pull:
	docker pull suderman/trusty

