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
sudo echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
```

### Configure swappiness
```
sudo echo 'vm.swappiness=10' >> /etc/sysctl.conf
```

### Configure Extra SSH port
```
sudo echo 'Port 2222' >> /etc/ssh/sshd_config
sudo service ssh restart
```

### Create data user/group on host
```
sudo useradd -mU -s /bin/bash -u 2000 data
sudo passwd data
sudo gpasswd -a $USER data  
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
sudo cd /data && mkdir -p apps audiobooks backup books code documents downloads fonts games media movies music personal projects public shows sync
sudo chown -R data:data /data
sudo chmod -R 774 /data
```

### Install and configure docker
```
sudo curl -sL https://get.docker.io/ | sh  
sudo gpasswd -a $USER docker  
sudo cp -f ubuntu/etc/default-docker /etc/default/docker  
sudo service docker restart  
```


### Configure firewall
```
sudo cp -f ubuntu/etc/default-ufw /etc/default/ufw  
sudo ufw reload  
sudo ufw allow 4243/tcp  
```

## Set-up for my router

See README.md in secret repo

