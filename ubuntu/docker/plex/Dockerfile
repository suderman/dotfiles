FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install tools and dependencies
RUN apt-get update
RUN apt-get install -y avahi-daemon avahi-utils unzip

# Download deb and install
# RUN curl http://downloads.plexapp.com/plex-media-server/0.9.9.7.429-f80a8d6/plexmediaserver_0.9.9.7.429-f80a8d6_amd64.deb -o /tmp/plex.deb
# RUN curl https://downloads.plex.tv/plex-media-server/0.9.10.0.581-cec9e01/plexmediaserver_0.9.10.0.581-cec9e01_amd64.deb -o /tmp/plex.deb
# RUN curl https://downloads.plex.tv/plex-media-server/0.9.10.1.585-f31034e/plexmediaserver_0.9.10.1.585-f31034e_amd64.deb -o /tmp/plex.deb
# RUN curl https://downloads.plex.tv/plex-media-server/0.9.11.4.739-a4e710f/plexmediaserver_0.9.11.4.739-a4e710f_amd64.deb -o /tmp/plex.deb
RUN curl https://downloads.plex.tv/plex-media-server/0.9.11.7.803-87d0708/plexmediaserver_0.9.11.7.803-87d0708_amd64.deb -o /tmp/plex.deb
RUN dpkg -i /tmp/plex.deb
RUN apt-get -yf install

# Define mountable directories.
VOLUME ["/config", "/library", "/media"]

# Add scripts 
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
