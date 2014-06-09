FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install tools and dependencies
RUN apt-get update
RUN apt-get install -y curl avahi-daemon avahi-utils

# Download deb and install
RUN curl http://downloads.plexapp.com/plex-media-server/0.9.9.7.429-f80a8d6/plexmediaserver_0.9.9.7.429-f80a8d6_amd64.deb -o /tmp/plex.deb
RUN dpkg -i /tmp/plex.deb
RUN apt-get -yf install

# Define mountable directories.
VOLUME ["/config", "/movies", "/shows", "/music", "/media", "/personal", "/downloads"]

# Start plex media server daemon 
ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

ENTRYPOINT ["/start.sh"]

# Expose ports.
EXPOSE 32400/tcp
EXPOSE 32443/tcp
