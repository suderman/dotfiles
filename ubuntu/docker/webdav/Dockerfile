FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install Apache
RUN                                                                      \
  apt-get update                                                      && \
  apt-get install -y                                                     \
          apache2                                                        \
          apache2-utils

# Setup Apache
RUN a2enmod dav dav_fs; a2ensite

# Setup permissions
RUN mkdir -p /data; chown data:data /data
RUN mkdir -p /var/lock/apache2; chown data:data /var/lock/apache2

# Define mountable directories
VOLUME ["/config", "/data"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# HTTP
EXPOSE 80/tcp
