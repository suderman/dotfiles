FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN apt-get update
RUN apt-get install -y dnsmasq

# Define mountable directories.
VOLUME ["/config"]

# Run this script whenever a DHCP lease is created/destroyed
ADD ./dhcp.sh /dhcp.sh

# Add scripts 
ADD ./config.sh   /config.sh
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# Expose ports.
EXPOSE 53/udp
EXPOSE 53/tcp
