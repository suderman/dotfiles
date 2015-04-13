FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install tools
RUN                                                       \
  add-apt-repository -y ppa:chris-lea/node.js          && \
  apt-get update                                       && \
  apt-get install -y nodejs

# Define mountable directories
VOLUME ["/config"]

# Add node app
RUN mkdir /ca
ADD ./server.js         /ca/server.js
ADD ./index.ejs         /ca/index.ejs
ADD ./package.json      /ca/package.json
ADD ./malformedRequest  /ca/malformedRequest
RUN cd /ca && npm install

# Add scripts 
ADD ./config.sh   /config.sh
ADD ./start.sh    /start.sh
ADD ./certify.sh  /certify.sh
ADD ./revoke.sh   /revoke.sh
ADD ./restart.sh  /restart.sh
RUN chmod u+x     /*.sh

# Start it up 
CMD ["/start.sh"]

# HTTPS web gui
EXPOSE 11443/tcp

# HTTP web gui
EXPOSE 11180/tcp

# OCSP responder
EXPOSE 11188/tcp
