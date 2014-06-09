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
VOLUME ["/config", "/downloads", "/movies", "/shows", "/music"]

# Start daemon 
ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

ENTRYPOINT ["/start.sh"]

# Expose ports.
EXPOSE 8080/tcp
EXPOSE 9090/tcp
