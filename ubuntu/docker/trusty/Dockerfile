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
  curl                                              \
  wget                                              \
  nano                                              \
  vim 

# Finish up
RUN dpkg-reconfigure locales
RUN apt-get clean
