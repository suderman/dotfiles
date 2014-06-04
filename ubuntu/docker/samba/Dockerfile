FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN apt-get update
RUN apt-get install -y avahi-daemon avahi-utils libnss-mdns libcups2 samba samba-common incron

# Add root as samba user, password: root
# RUN (echo root; echo root) | smbpasswd -a root -s

# Add data as samba user, password: data
RUN (echo data; echo data) | smbpasswd -a data -s

# Define mountable directories
VOLUME ["/config", "/media", "/downloads"]

# Watch for file changes to reload daemon
ADD incron.root /var/spool/incron/root
RUN echo 'root' >> /etc/incron.allow

# Config script 
ADD ./config.sh /config.sh
RUN chmod u+x  /config.sh

# Start script 
ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

CMD ["/start.sh"]
