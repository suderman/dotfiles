#!/bin/sh

# 2014 Jon Suderman
# https://github.com/suderman/local

ACTION=$1
MAC_ADDRESS=$2
IP_ADDRESS=$3
HOSTNAME=$4
HOSTFILE=/config/hosts.dhcp

# When adding an address, add the client's hostname to the hostfile
if [ "$ACTION" == "add" ]; then
  echo "#$MAC_ADDRESS\n$IP_ADDRESS        $HOSTNAME\n" >> $HOSTFILE

# When removing an address, remove the client's hostname from the hostfile
elif [ "$ACTION" == "del" ]; then
  echo "$(sed -e "/$MAC_ADDRESS/,+2 d" $HOSTFILE)" > $HOSTFILE
fi

