FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN apt-get update
RUN apt-get install -y dnsmasq incron

# Watch for file changes to reload dnsmasq
ADD incron.root /var/spool/incron/root
RUN echo 'root' >> /etc/incron.allow

# Define mountable directories.
VOLUME ["/config"]

# Run this script whenever a DHCP lease is created/destroyed
ADD ./dhcp.sh /dhcp.sh
RUN chmod u+x  /dhcp.sh

# Symlink config scripts, start incron & dnsmasq daemon 
ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

ENTRYPOINT ["/start.sh"]

# Expose ports.
EXPOSE 53/udp
EXPOSE 53/tcp
