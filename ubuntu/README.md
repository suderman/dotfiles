Ubuntu configuration and scripts
===============================

## What's this?

This is my collection of scripts and configuration files for all of my Ubuntu systems. 

## Set-up for my systems

Install dotfiles and other configuration:    
```
bash <(curl https://raw.githubusercontent.com/suderman/local/master/bin/init)
```

## Set-up for my Intel NUC

All commands are relative to this repo's root.  

### Get sudo powers
```
sudo bash  
```

### Configure hostname
```
cp -f ubuntu/etc/hostname /etc/hostname  
```

### Configure networking
```
cp -f ubuntu/etc/network-interfaces /etc/network/interfaces  
```

### Configure swappiness
```
echo 'vm.swappiness=10' >> /etc/sysctl.conf
```

### Configure Extra SSH port
```
echo 'Port 2222' >> /etc/ssh/sshd_config
service ssh restart
```

### Create data user on host
```
mkdir -p /data
useradd --home-dir /data --shell /bin/bash data
usermod -p data data && usermod -U data
usermod -u 2000 data && groupmod -g 2000 data
gpasswd -a ${USER} data
```

### Reboot to ensure changes take effect
```
reboot
```

### More sudo powers
```
sudo bash  
```

### Partition and format USB drive
```
parted -l
umount /dev/sdb
fdisk /dev/sdb
(o, n, 1, p, w)
mkfs.ext4 -L usbdrive /dev/sdb1
```

### Mount USB drive and create structure
```
mkdir -p /data
mount /dev/disk/by-label/usbdrive /data
cd /data && mkdir -p apps audiobooks backup books code documents downloads fonts games media movies music personal projects public shows sync
chown -R data:data /data
chmod -R 774 /data
```

### Create docker host data volume, symlink USB drive
```
mkdir -p /config
```

### Install and configure docker
```
curl -sL https://get.docker.io/ | sh  
gpasswd -a ${USER} docker  
cp -f ubuntu/etc/default-docker /etc/default/docker  
service docker restart  
```


### Configure firewall
```
cp -f ubuntu/etc/default-ufw /etc/default/ufw  
ufw reload  
ufw allow 4243/tcp  
```



### Start docker container services

####certificate authority
`cd ~/.local/ubuntu/docker/ca && d start`

####dnsmasq
`cd ~/.local/ubuntu/docker/dnsmasq && d start`

####samba
`cd ~/.local/ubuntu/docker/samba && d start`

####mariadb
`cd ~/.local/ubuntu/docker/mariadb && d start`

####homemaker
`cd ~/.local/ubuntu/docker/homemaker && d start`

####plex
`cd ~/.local/ubuntu/docker/plex && d start`

####plexconnect
`cd ~/.local/ubuntu/docker/plexconnect && d start`

####btsync
`cd ~/.local/ubuntu/docker/btsync && d start`

####sabnzbd
`cd ~/.local/ubuntu/docker/sabnzbd && d start`

####couchpotato
`cd ~/.local/ubuntu/docker/couchpotato && d start`

####webdav
`cd ~/.local/ubuntu/docker/webdav && d start`

####nginx
`cd ~/.local/ubuntu/docker/nginx && d start`

#### Others still to set up:
- openvpn
- nzbdrone
- nzbget
- transmission
- mpd
- NZBmegasearcH
- kandan
- Redis
- ZNC
- tmate

## Set-up for my router

See README.md in secret repo

