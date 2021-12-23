#!/bin/bash

export HOSTNAME=arch
export USERNAME=suderman
export USERPASS=password
export ROOTPASS=password

#   # ------------------------------------------
#   # Connect to WiFi:
#   # ------------------------------------------
#
#   # Get network device name
#   ip -c a
#
#   # Connect to network
#   iwctl
#   [iwd] station wlan0 connect suderman
#
#   # Test connection by refreshing packages
#   pacman -Sy
#
#
#   # ------------------------------------------
#   # Preconfigure:
#   # ------------------------------------------
#
#   # Ensure booted with EFI mode
#   ls /sys/firmware/efi/efivars
#
#   # Set and check time
#   timedatectl set-ntp true
#   timedatectl status
#
#
#   # ------------------------------------------
#   # Partition disks:
#   # ------------------------------------------
#
#   # List devices
#   lsblk
#
#   # Create partitions
#   cgdisk /dev/nvme0n1
#   #- boot: NEW, default, 512M, ef00
#   #- swap: NEW, default, 32G, 8200
#   #- root: NEW, default, default, 8300
#
#   # ------------------------------------------
#   # Format partitions:
#   # ------------------------------------------
#
#   # Format boot partition
#   mkfs.fat -F32 /dev/nvme0n1p1
#
#   # Format swap partition
#   mkswap /dev/nvme0n1p2
#   swapon /dev/nvme0n1p2
#
#   # Format root partition
#   mkfs.btrfs -L root /dev/nvme0n1p3
#
#   # Create btrfs subvolumes
#   mount /dev/nvme0n1p3 /mnt
#   cd /mnt
#   btrfs subvolume create @
#   btrfs subvolume create @home
#   btrfs subvolume create @log
#   btrfs subvolume create @docker
#   umount /mnt
#
#
#   # ------------------------------------------
#   # Mount volumes:
#   # ------------------------------------------
#
#   # Mount root subvolume
#   mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/nvme0n1p3 /mnt
#
#   # Mount boot partition
#   mkdir /mnt/boot
#   mount /dev/nvme0n1p1 /mnt/boot
#
#   # Mount home subvolume
#   mkdir /mnt/home
#   mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/nvme0n1p3 /mnt/home
#
#   # Mount log subvolume
#   mkdir /mnt/log
#   mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/nvme0n1p3 /mnt/var/log
#
#   Mount docker subvolume
#   mkdir -p /mnt/var/lib/docker
#   mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@docker /dev/nvme0n1p3 /mnt/var/lib/docker
#
#
#   # ------------------------------------------
#   # Create fstab from mounts:
#   # ------------------------------------------
#
#   # Verify partitions and subvolumes
#   lsblk
#   btrfs subvolume list /mnt
#
#   # Generate fstab
#   genfstab -U /mnt >> /mnt/etc/fstab
#
#
#   # ------------------------------------------
#   # Install base packages:
#   # ------------------------------------------
#
#   # Install base packages to new volume
#   pacstrap /mnt base base-devel linux linux-firmware git vim intel-ucode
#   
#
#   # ------------------------------------------
#   # Enter system and run install script:
#   # ------------------------------------------
#
#   # Enter installation
#   arch-chroot /mnt
#   
#   # Download install script, edit and run
#   git clone https://github.com/suderman/dotfiles.git /tmp/dotfiles
#   sh /tmp/dotfiles/base.sh
#
#

# Timezone
ln -sf /usr/share/zoneinfo/Canada/Mountain /etc/localtime
hwclock --systohc

# Locale
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen

# Hostname (change for each device)
echo "$HOSTNAME" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# Root password
echo root:$ROOTPASS | chpasswd

# Packages
pacman -Syy
pacman -S grub efibootmgr network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font grub-btrfs docker

# Enable Grub's OS prober
echo GRUB_DISABLE_OS_PROBER=false >> /etc/default/grub

# Add deep suspend to kernel parameters
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet mem_sleep_default=deep"/' /etc/default/grub

# Install and config Grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Configure Docker
mkdir -p /etc/docker
echo '{' >> /etc/docker/daemon.json
echo '  "storage-driver": "btrfs"' >> /etc/docker/daemon.json
echo '}' >> /etc/docker/daemon.json


# System Services
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid
systemctl enable docker

# User
useradd -m $USERNAME
echo $USERNAME:$USERPASS | chpasswd
usermod -aG libvirt $USERNAME
usermod -aG docker $USERNAME
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers.d/$USERNAME


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

