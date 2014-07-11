FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install tools
RUN                                                       \
  add-apt-repository -y ppa:ondrej/php5                && \
  add-apt-repository -y ppa:nginx/stable               && \
  apt-get update                                       && \
  apt-get install -y                                      \
          php5-fpm                                        \
          php5-cli                                        \
          php5-common                                     \
          php5-json                                       \
          nginx                                        && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories
VOLUME ["/config"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./new.sh      /new.sh
ADD ./revoke.sh   /revoke.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# Expose ports
EXPOSE 8008/tcp
