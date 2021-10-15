#!/bin/bash

#   # Ensure booted with EFI mode
#   ls /sys/firmware/efi/efivars
#   
#   # Set and check time
#   timedatectl set-ntp true
#   timedatectl status
#   
#   # Partition disk
#   lsblk
#   cfdisk /dev/sda
#   - boot: 512M, ef00
#   - swap: 32G, 8200
#   - root: 100G, 8300
#   - test: 100G, 8300
#   - home: (remainder), 8302
#   
#   # Format partitions
#   mkfs.fat -F32 /dev/sda1
#   mkswap -L swap /dev/sda2
#   mkfs.btrfs -L root /dev/sda3
#   mkfs.btrfs -L test /dev/sda4
#   mkfs.btrfs -L home /dev/sda5
#   
#   # Mount volumes
#   mount /dev/sda3 /mnt
#   mkdir /mnt/boot
#   mount /dev/sda1 /mnt/boot
#   mkdir /mnt/home
#   mount /dev/sda4 /mnt/home
#   swapon /dev/sda2
#   
#   # Install packages to new volume
#   pacstrap /mnt base base-devel linux linux-firmware git vim intel-ucode
#   # pacstrap /mnt base base-devel linux linux-firmware netctl dialog wpa_supplicant git vim tmux zsh
#   
#   # Generate & save fstab (change relatime to noatime for non-boot volume)
#   genfstab -U /mnt >> /mnt/etc/fstab
#   
#   # Enter installation
#   arch-chroot /mnt
#   
#   # Download install script and run
#   git clone https://github.com/suderman/dotfiles.git /tmp/dotfiles
#   sh /tmp/dotfiles/base.sh

# Timezone
ln -sf /usr/share/zoneinfo/Canada/Mountain /etc/localtime
hwclock --systohc

sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de_CH-latin1" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd

# You can add xorg to the installation packages, I usually add it at the DE or WM install script
# You can remove the tlp package if you are installing on a desktop or vm

pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp # You can comment this command out if you didn't install tlp, see above
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid

useradd -m ermanno
echo ermanno:password | chpasswd
usermod -aG libvirt ermanno

echo "ermanno ALL=(ALL) ALL" >> /etc/sudoers.d/ermanno


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"


