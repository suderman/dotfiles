#!/bin/sh
cp -f /config/avahi-daemon.conf     /etc/avahi/avahi-daemon.conf
cp -f /config/smb.conf              /etc/samba/smb.conf
cp -f /config/samba.service         /etc/avahi/services/samba.service
