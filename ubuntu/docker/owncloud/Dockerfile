FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN                                                                      \
  apt-get update                                                      && \
  apt-get install -y                                                     \
          apache2                                                        \
          php5                                                           \
          php5-gd                                                        \
          php-xml-parser                                                 \
          php5-intl                                                      \
          php5-sqlite                                                    \
          mysql-server-5.5                                               \
          smbclient                                                      \
          libcurl3                                                       \
          php5-mysql                                                     \
          php5-curl                                                      \
          bzip2                                                          \
          sharutils

RUN wget -q -O - http://download.owncloud.org/community/owncloud-6.0.3.tar.bz2 | tar jx -C /var/www/
RUN chown -R www-data:www-data /var/www/owncloud

# Enable apache rewrites
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
RUN a2enmod rewrite

# Define mountable directories.
VOLUME ["/config", "/data"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# Expose ports.
EXPOSE 80/tcp
