FROM ubuntu:trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

# Expand the sources list
RUN rm /etc/apt/sources.list
ADD ./sources.list /etc/apt/sources.list

# Update everything
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get --assume-yes dist-upgrade

# Include a few basics
RUN apt-get install -y                              \
  language-pack-en-base                             \
  software-properties-common                        \
  build-essential                                   \
  git                                               \
  zip                                               \
  curl                                              \
  wget                                              \
  nano                                              \
  vim                                               \
  openssh-server                                    \
  incron
RUN dpkg-reconfigure locales
RUN apt-get clean

# Helper script to source in other scripts
ADD helper.sh /helper.sh
RUN chmod u+x  /helper.sh

# Watch for file changes to reload service
RUN mkdir /config
ADD restart.txt /config/restart.txt

# Replace this restart script with one that does something!
ADD restart.sh /restart.sh
RUN chmod u+x  /restart.sh

# Run restart.sh whenever incron detects restart.txt was touched
# /usr/sbin/incrond
ADD incron.root /var/spool/incron/root
RUN echo 'root' >> /etc/incron.allow

# Add data user with specific uid/gid 
# (don't forget a matching user/group on the host)
RUN useradd --home-dir / --shell /bin/bash data
RUN usermod -p data data && usermod -U data
RUN usermod -u 2000 data && groupmod -g 2000 data

# Allow SSH connections to the container
# /usr/sbin/sshd
RUN mkdir /var/run/sshd 
RUN sed -ri 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd

# Set TERM environment variable
ENV TERM dumb

EXPOSE 22/tcp
