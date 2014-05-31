FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install Nginx.
RUN                                                                      \
  add-apt-repository -y ppa:nginx/stable                              && \
  apt-get update                                                      && \
  apt-get install -y nginx incron                                     && \
  chown -R www-data:www-data /var/lib/nginx

# echo "\ndaemon off;" >> /etc/nginx/nginx.conf                       && \

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled"]

# Watch for file changes to reload nginx
ADD incron.root /var/spool/incron/root
RUN echo 'root' >> /etc/incron.allow

# Define working directory.
WORKDIR /etc/nginx

# Start incron & nginx daemon, and tail logs 
ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh
CMD ["/start.sh"]

# Expose ports.
EXPOSE 80/tcp
EXPOSE 8000/tcp
EXPOSE 443/tcp
