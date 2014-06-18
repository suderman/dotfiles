FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN                                                                       \
  apt-get update                                                       && \
  apt-get install -y                                                      \
          avahi-daemon                                                    \
          avahi-utils                                                     \
          libnss-mdns                                                     \
          libcups2                                                        \
          samba                                                           \
          samba-common

# Add data as samba user, password: data
RUN (echo data; echo data) | smbpasswd -a data -s

# Define mountable directories
VOLUME ["/config", "/data"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up
CMD ["/start.sh"]

# Expose ports
EXPOSE 445/tcp
EXPOSE 139/tcp
EXPOSE 135/tcp
EXPOSE 137/udp
EXPOSE 138/udp
