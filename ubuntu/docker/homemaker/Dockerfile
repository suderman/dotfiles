FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install tools
RUN                                                       \
  add-apt-repository -y ppa:chris-lea/node.js          && \
  apt-get update --fix-missing                         && \
  apt-get install -y                                      \
          python2.7                                       \
          python-openssl                                  \
          nodejs
RUN npm install -g node-gyp

# Install application
RUN cd /                                                && \
    git clone https://github.com/suderman/homemaker.git && \
    cd /homemaker                                       && \
    npm install                                         && \
    npm run symlink                                     && \
    npm run build

# Define mountable directories
VOLUME ["/config"]

# Add scripts 
ADD ./config.sh   /config.sh
ADD ./start.sh    /start.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up
CMD ["/start.sh"]

# Expose ports
EXPOSE 7000/tcp
EXPOSE 7001/tcp
