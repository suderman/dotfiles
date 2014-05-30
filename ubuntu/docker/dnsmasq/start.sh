#!/bin/sh

# Link config file to where it's expected
ln -sf /config/dnsmasq.conf /etc/dnsmasq.conf

# Link ethers file to where it's expected
ln -sf /config/ethers /etc/ethers

# Link hosts file to where it's expected
ln -sf /config/hosts /etc/hosts.local

# Link dhcp hosts file to where it's expected
ln -sf /config/hosts.dhcp /etc/hosts.dhcp

# Start incrond to watch for file changes in /config
/usr/sbin/incrond

# Start it up
/usr/sbin/dnsmasq

# Watch the log and keep the container alive
touch /dnsmasq.log
tail -f /dnsmasq.log
