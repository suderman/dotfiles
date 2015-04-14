FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install Nginx.
RUN                                                                      \
  add-apt-repository -y ppa:nginx/stable                              && \
  apt-get update  --fix-missing                                       && \
  apt-get install -y nginx                                            && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/config", "/public", "/downloads"]

# Define working directory.
WORKDIR /etc/nginx

# Add scripts 
ADD ./config.sh   /config.sh
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# Private HTTP
EXPOSE 80/tcp

# Private HTTPS
EXPOSE 443/tcp

# Public HTTP
EXPOSE 8000/tcp

# Public HTTPS
EXPOSE 4430/tcp
