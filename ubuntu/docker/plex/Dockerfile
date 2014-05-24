FROM ubuntu:trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

RUN locale-gen en_US en_US.UTF-8
RUN apt-get update

RUN apt-get install -y curl avahi-daemon avahi-utils
RUN curl http://downloads.plexapp.com/plex-media-server/0.9.9.7.429-f80a8d6/plexmediaserver_0.9.9.7.429-f80a8d6_amd64.deb -o /tmp/plex.deb
RUN dpkg -i /tmp/plex.deb
RUN apt-get -yf install

VOLUME /config
VOLUME /media

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 32400

ENTRYPOINT ["/start.sh"]
