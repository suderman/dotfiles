#!/bin/bash

# Update these before running script
export HOSTNAME=arch
export USERNAME=suderman
export USERPASS=password
export ROOTPASS=password

#   # ---------------------------------------------
#   # Connect to WiFi:
#   # ---------------------------------------------
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
#   # ---------------------------------------------
#   # Preconfigure:
#   # ---------------------------------------------
#
#   # Ensure booted with EFI mode
#   ls /sys/firmware/efi/efivars
#
#   # Set and check time
#   timedatectl set-ntp true
#   timedatectl status
#
#
#   # ---------------------------------------------
#   # Partition & format data disk (if applicable):
#   # ---------------------------------------------
#
#   # List devices
#   lsblk -f
#
#   # Create partitions
#   cgdisk /dev/sda
#   #- data: NEW, default, default, 8300
#
#   # Create btrfs subvolumes
#   mount /dev/sda1 /mnt
#   cd /mnt
#   btrfs subvolume create @
#   btrfs subvolume create @data
#   cd / && umount /mnt
#
#   # ---------------------------------------------
#   # Partition & format root disk:
#   # ---------------------------------------------
#
#   # List devices
#   lsblk -f
#
#   # Create partitions
#   cgdisk /dev/nvme0n1
#   #- boot: NEW, default, 512M, ef00
#   #- swap: NEW, default, 32G, 8200
#   #- root: NEW, default, default, 8300
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
#   cd / && umount /mnt
#
#   # ---------------------------------------------
#   # Mount root volumes:
#   # ---------------------------------------------
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
#   mkdir -p /mnt/var/log
#   mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/nvme0n1p3 /mnt/var/log
#
#   # Mount docker subvolume
#   mkdir -p /mnt/var/lib/docker
#   mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@docker /dev/nvme0n1p3 /mnt/var/lib/docker
#
#   # Mount data subvolume (if applicable):
#   mkdir /mnt/data
#   mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@data /dev/sda1 /mnt/data
#
#   # ---------------------------------------------
#   # Create fstab from mounts:
#   # ---------------------------------------------
#
#   # Verify partitions and subvolumes
#   lsblk -f
#   btrfs subvolume list /mnt
#
#   # Generate fstab
#   genfstab -U /mnt >> /mnt/etc/fstab
#
#
#   # ---------------------------------------------
#   # Install base packages:
#   # ---------------------------------------------
#
#   # Install base packages to new volume
#   pacstrap /mnt base base-devel linux linux-firmware git vim intel-ucode
#   
#
#   # ---------------------------------------------
#   # Enter system and run install script:
#   # ---------------------------------------------
#
#   # Enter installation
#   arch-chroot /mnt
#   
#   # Download install script, edit and run
#   git clone https://github.com/suderman/dotfiles.git /tmp/dotfiles
#   sh /tmp/dotfiles/arch.sh
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
pacman -S acpi acpi_call acpid alsa-utils arch-install-scripts avahi bash-completion bluez bluez-utils bridge-utils cups dialog dnsmasq dnsutils dosfstools edk2-ovmf efibootmgr firewalld flatpak grub grub-btrfs gvfs gvfs-smb hplip inetutils ipset iptables-nft linux-headers man-db mtools network-manager-applet nfs-utils nss-mdns ntfs-3g openbsd-netcat openssh os-prober pipewire pipewire-alsa pipewire-jack pipewire-pulse qemu qemu-arch-extra reflector rsync sof-firmware tlp vde2 virt-manager wpa_supplicant xdg-user-dirs xdg-utils zsh

# Enable Grub's OS prober
echo GRUB_DISABLE_OS_PROBER=false >> /etc/default/grub

# Add deep suspend to kernel parameters
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=".*"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet mem_sleep_default=deep"/' /etc/default/grub

# Install and config Grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

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


# Install & configure Docker for bfrfs
pacman -S docker
mkdir -p /etc/docker
echo '{' >> /etc/docker/daemon.json
echo '  "storage-driver": "btrfs"' >> /etc/docker/daemon.json
echo '}' >> /etc/docker/daemon.json
systemctl enable docker


# Install Gnome
pacman -S gnome
systemctl enable gnome


# Configure Interception caps2esc
pacman -S interception-caps2esc
mkdir -p /etc/interception/udevmon.d
echo '- JOB: intercept -g $DEVNODE | caps2esc -m 1 | uinput -d $DEVNODE' >> /etc/interception/udevmon.d/caps2esc.yaml
echo '  DEVICE:' >> /etc/interception/udevmon.d/caps2esc.yaml
echo '    EVENTS:' >> /etc/interception/udevmon.d/caps2esc.yaml
echo '      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]' >> /etc/interception/udevmon.d/caps2esc.yaml
systemctl enable udevmon


# Install tailscale
pacman -S tailscale
systemctl enable tailscaled


# Install paru
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si


# User
useradd -m $USERNAME
echo $USERNAME:$USERPASS | chpasswd
usermod -aG libvirt $USERNAME
usermod -aG docker $USERNAME
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers.d/$USERNAME
chsh -s /usr/bin/zsh $USERNAME

# Override system's gnome-terminal with script in user's .local/bin directory
ln -sf /home/$USERNAME/.local/bin/gnome-terminal /usr/local/bin/gnome-terminal
chown -R $USERNAME:$USERNAME /usr/local/bin


# Done
printf "\e[1;32mDone! Reboot and login as user.\e[0m"


#   # ---------------------------------------------
#   # Final steps onced logged in as user:
#   # ---------------------------------------------
#
#   # Goodies
#   sudo pacman -S --needed neovim neomutt mosh zsh tmux fzf ncdu ranger micro htop jq lazydocker firefox
#   paru -S --needed foot lf-bin
#
#   # https://github.com/harshadgavali/searchprovider-for-browser-tabs/
#   xdg-open https://addons.mozilla.org/firefox/downloads/file/3887875/tab_search_provider_for_gnome-1.0.1-fx.xpi
#   gnome-extensions install https://extensions.gnome.org/extension-data/browser-tabscom.github.harshadgavali.v4.shell-extension.zip
#   paru -S --needed tabsearchproviderconnector
#
#   # Gnome settings
#   gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']" 
#   gsettings get org.gnome.desktop.peripherals.touchpad disable-while-typing
