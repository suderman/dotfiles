FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN apt-get update
RUN apt-get install -y dnsmasq incron

# # Watch for file changes to reload dnsmasq
# ADD incron.root /var/spool/incron/root
# RUN echo 'root' >> /etc/incron.allow

# Define mountable directories.
VOLUME ["/config"]

# Run this script whenever a DHCP lease is created/destroyed
ADD ./dhcp.sh /dhcp.sh
RUN chmod u+x  /dhcp.sh

# Add scripts 
ADD ./start.sh    /start.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# Expose ports.
EXPOSE 53/udp
EXPOSE 53/tcp
