FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install tools and dependencies
RUN apt-get update --fix-missing
RUN apt-get install -y avahi-daemon avahi-utils unzip

# Download deb and install
RUN curl https://downloads.plex.tv/plex-media-server/0.9.11.17.986-269b82b/plexmediaserver_0.9.11.17.986-269b82b_amd64.deb -o /tmp/plex.deb
RUN dpkg -i /tmp/plex.deb
RUN apt-get -yf install

# Define mountable directories.
VOLUME ["/config", "/library", "/media"]

# Add scripts 
ADD ./config.sh   /config.sh
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up
CMD ["/start.sh"]

# Expose ports
EXPOSE 32400/tcp
EXPOSE 32443/tcp
EXPOSE 1900/udp
EXPOSE 32410/udp
EXPOSE 32412/udp
EXPOSE 32413/udp
EXPOSE 32414/udp
EXPOSE 32469/tcp
