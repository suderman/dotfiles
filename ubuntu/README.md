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

### Configure hostname
```
sudo cp -f ubuntu/etc/hostname /etc/hostname  
```

### Configure networking
```
sudo cp -f ubuntu/etc/network-interfaces /etc/network/interfaces  
```

### Configure swappiness
```
sudo bash
echo 'vm.swappiness=10' >> /etc/sysctl.conf
exit
```


### Create data user on host
```
sudo mkdir -p /data
sudo useradd --home-dir /data --shell /bin/bash data
sudo usermod -p data data && usermod -U data
sudo usermod -u 2000 data && groupmod -g 2000 data
sudo gpasswd -a ${USER} data
```

### Reboot to ensure changes take effect
```
sudo reboot
```

### Partition and format USB drive
```
sudo parted -l
sudo umount /dev/sdb
sudo fdisk /dev/sdb
(o, n, 1, p, w)
sudo mkfs.ext4 -L usbdrive /dev/sdb1
```

### Mount USB drive and create structure
```
sudo mkdir -p /data
sudo mount /dev/disk/by-label/usbdrive /data
cd /data && sudo mkdir -p apps audiobooks backup books code documents downloads fonts
games media movies music personal projects public shows sync
sudo chown -R data:data /data
sudo chmod -R 774 /data
```

### Create docker host data volume, symlink USB drive
```
sudo mkdir -p /config
```

### Install and configure docker
```
curl -sL https://get.docker.io/ | sh  
sudo gpasswd -a ${USER} docker  
sudo cp -f ubuntu/etc/default-docker /etc/default/docker  
sudo service docker restart  
```


### Configure firewall
```
sudo cp -f ubuntu/etc/default-ufw /etc/default/ufw  
sudo ufw reload  
sudo ufw allow 4243/tcp  
```



### Start docker container services

####dnsmasq
`cd ~/.local/ubuntu/docker/dnsmasq && d start`

####samba
`cd ~/.local/ubuntu/docker/samba && d start`

####openvpn
`cd ~/.local/ubuntu/docker/openvpn && d start`

####nginx
`cd ~/.local/ubuntu/docker/nginx && d start`

####plex
`cd ~/.local/ubuntu/docker/plex && d start`

#### Others still to set up:
- dnsmasq
- openvpn
- nzbdrone
- nzbget
- transmission
- mpd (Music Player Daemon)
- NZBmegasearcH
- kandan
- MySQL
- Redis
- ZNC
- tmate
- mosh
- api
- owncloud

## Set-up for my router

See README.md in secret repo

