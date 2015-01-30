FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN apt-get update
RUN apt-get install -y openvpn iptables socat curl incron

# Define mountable directories
VOLUME ["/config"]

ADD ./client.opvn.template /config/client.opvn.template
ADD ./generate-client-keys.sh /generate-client-keys.sh
RUN chmod u+x  /generate-client-keys.sh

# Config script 
ADD ./config.sh /config.sh
RUN chmod u+x  /config.sh

# Start script 
ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

CMD ["/start.sh"]

# Expose ports.
EXPOSE 443/tcp
EXPOSE 1194/udp
EXPOSE 8194/udp
