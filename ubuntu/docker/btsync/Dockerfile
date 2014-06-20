FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install btsync
RUN curl -o /usr/bin/btsync.tar.gz http://download-lb.utorrent.com/endpoint/btsync/os/linux-x64/track/stable
RUN cd /usr/bin && tar -xzvf btsync.tar.gz && rm btsync.tar.gz 

# Define mountable directories
VOLUME ["/config", "/data"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up
CMD ["/start.sh"]

# Web GUI
EXPOSE 8888/tcp

# Listening port
EXPOSE 55555/tcp
