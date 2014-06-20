FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN                                                                      \
  apt-get update                                                      && \
  apt-get install -y                                                     \
          sabnzbdplus                                                    \
          sabnzbdplus-theme-classic                                      \
          sabnzbdplus-theme-mobile                                       \
          sabnzbdplus-theme-plush                                        \
          par2                                                           \
          python-yenc                                                    \
          unrar                                                          \
          unzip                                                          

# Define mountable directories.
VOLUME ["/config", "/downloads", "/library"]

# Add scripts 
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up
CMD ["/start.sh"]

# Expose ports.
EXPOSE 8080/tcp
EXPOSE 9090/tcp
