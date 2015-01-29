FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install dependencies
RUN                                                                      \
  apt-get update                                                      && \
  apt-get install -y                                                     \
          python2.7                                                      \
          python-openssl

# Install application
RUN cd / && git clone https://github.com/iBaa/PlexConnect

# # Apply patch
# ADD ./patch.txt   /patch.txt
# RUN cd /PlexConnect && git apply /patch.txt
#
# Define mountable directories.
VOLUME ["/config"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up
CMD ["/start.sh"]

# Expose ports.
EXPOSE 10443/tcp
EXPOSE 10080/tcp
# EXPOSE 53/udp
