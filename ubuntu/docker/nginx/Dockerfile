FROM suderman/trusty

MAINTAINER Jon Suderman <suderman@gmail.com>

# Install Nginx.
RUN                                                                      \
  add-apt-repository -y ppa:nginx/stable                              && \
  apt-get update                                                      && \
  apt-get install -y nginx incron                                     && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf                       && \
  chown -R www-data:www-data /var/lib/nginx

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/sites-available"]

# Watch for file changes to reload nginx
ADD incron.root /var/spool/incron/root
RUN echo 'root' >> /etc/incron.allow

# Define working directory.
WORKDIR /etc/nginx

# Start incron & nginx daemon, and tail logs 
ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

ENTRYPOINT ["/start.sh"]

# Expose ports.
EXPOSE 80/tcp
EXPOSE 8080/tcp
EXPOSE 443/tcp
