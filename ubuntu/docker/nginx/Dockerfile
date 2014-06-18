FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install Nginx.
RUN                                                                      \
  add-apt-repository -y ppa:nginx/stable                              && \
  apt-get update                                                      && \
  apt-get install -y nginx                                            && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/config"]

# Define working directory.
WORKDIR /etc/nginx

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# Private HTTP
EXPOSE 80/tcp

# Public HTTP
EXPOSE 8000/tcp

# Secure HTTP
EXPOSE 443/tcp
