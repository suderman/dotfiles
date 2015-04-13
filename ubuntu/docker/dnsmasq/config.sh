#!/bin/bash
source /helper.sh

# Set environment variables
DOMAIN=`getenv DOMAIN localhost`
HOST_IP=`getenv HOST_IP localhost`
GATEWAY_IP=`getenv GATEWAY_IP localhost`

# Copy config files to where they're expected
ln -sf /config/ethers /etc/ethers
ln -sf /config/hosts /etc/hosts.local
ln -sf /config/hosts.dhcp /etc/hosts.dhcp

cp -f /config/dnsmasq.conf  /etc/dnsmasq.conf
expenv DOMAIN               /etc/dnsmasq.conf
expenv HOST_IP              /etc/dnsmasq.conf
expenv GATEWAY_IP           /etc/dnsmasq.conf
