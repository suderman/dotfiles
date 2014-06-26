FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install Apache
RUN                                                                      \
  apt-get update                                                      && \
  apt-get install -y                                                     \
          apache2                                                        \
          apache2-utils

RUN a2enmod dav dav_fs; a2ensite
RUN mkdir -p /data; chown data:data /data
RUN mkdir -p /var/lock/apache2; chown data:data /var/lock/apache2
RUN rm /var/www/html/index.html; touch /var/www/html/index.html

ENV APACHE_RUN_USER data
ENV APACHE_RUN_GROUP data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

# Define mountable directories.
VOLUME ["/config", "/data"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# HTTP
EXPOSE 80/tcp
