FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install Apache
RUN                                                                      \
  apt-get update                                                      && \
  apt-get install -y                                                     \
          apache2                                                        \
          apache2-utils                                                  \
          php5                                                           \
          libapache2-mod-php5

# Setup Apache
RUN a2enmod dav dav_fs; a2ensite
RUN mkdir -p /var/lock/apache2

# Add command `git clone-pull`
RUN curl suderman.github.io/git-clone-pull/install | sh

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
