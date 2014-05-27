#!/bin/sh

# Copy config file to where it's expected
rm -f /etc/dnsmasq.conf
cp /config/dnsmasq.conf /etc/dnsmasq.conf

# Copy ethers file to where it's expected
rm -f /etc/ethers
cp /config/ethers /etc/ethers

# Copy hosts file to where it's expected
rm -f /etc/hosts.local
cp /config/hosts /etc/hosts.local

# Start it up
/usr/sbin/dnsmasq --no-daemon
