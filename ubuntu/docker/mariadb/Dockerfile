FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install MariaDB
RUN                                                                                                                            \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0xcbcb082a1bb943db                                           && \
  echo "deb http://mariadb.mirror.iweb.com/repo/10.0/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/mariadb.list  && \
  apt-get update                                                                                                            && \
  apt-get install -y                                                                                                           \
          mariadb-server                                                                                                       \
          inotify-tools

# Define mountable directories
VOLUME ["/config"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# Expose ports
EXPOSE 3306/tcp
