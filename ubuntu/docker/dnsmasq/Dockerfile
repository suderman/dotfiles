FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN apt-get update
RUN apt-get install -y dnsmasq

VOLUME /config

EXPOSE 53/udp

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

ENTRYPOINT ["/start.sh"]
