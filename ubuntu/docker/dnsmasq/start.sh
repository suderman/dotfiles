#!/bin/bash
source /helper.sh

# -------------------------------------------
# Start common services
# -------------------------------------------

# Start incrond to watch /config/restart.txt
/usr/sbin/incrond

# Start sshd
/usr/sbin/sshd

# -------------------------------------------
# Set environment variables
# -------------------------------------------

DOMAIN=`getenv DOMAIN localhost`
HOST_IP=`getenv HOST_IP localhost`
GATEWAY_IP=`getenv GATEWAY_IP localhost`

# -------------------------------------------
# Copy config files to where they're expected
# -------------------------------------------

# ln -sf /config/dnsmasq.conf /etc/dnsmasq.conf
ln -sf /config/ethers /etc/ethers
ln -sf /config/hosts /etc/hosts.local
ln -sf /config/hosts.dhcp /etc/hosts.dhcp

cp -f /config/dnsmasq.conf  /etc/dnsmasq.conf
expenv DOMAIN               /etc/dnsmasq.conf
expenv HOST_IP              /etc/dnsmasq.conf
expenv GATEWAY_IP           /etc/dnsmasq.conf

# -------------------------------------------
# Start this container's services
# -------------------------------------------

# Generate /config/blacklist.conf
/adblock.sh

# Start it up
/usr/sbin/dnsmasq

# Watch the log and keep the container alive
touch /dnsmasq.log
tail -f /dnsmasq.log

# #!/bin/sh
#
# # Link config file to where it's expected
# ln -sf /config/dnsmasq.conf /etc/dnsmasq.conf
#
# # Link ethers file to where it's expected
# ln -sf /config/ethers /etc/ethers
#
# # Link hosts file to where it's expected
# ln -sf /config/hosts /etc/hosts.local
#
# # Link dhcp hosts file to where it's expected
# ln -sf /config/hosts.dhcp /etc/hosts.dhcp
#
# # Start incrond to watch for file changes in /config
# /usr/sbin/incrond
#
# # Start it up
# /usr/sbin/dnsmasq
#
# # Watch the log and keep the container alive
# touch /dnsmasq.log
# tail -f /dnsmasq.log
