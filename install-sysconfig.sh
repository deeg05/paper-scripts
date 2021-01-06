#!/bin/bash

#
# Paper sysconfig script
# Use in chroot of fresh paper installation
# 

# Set neovim as default editor
export EDITOR="/usr/bin/nvim"
#
# Basic system configuration
#

# Ask user about region and city

echo 'Configuring timezone'
read -p 'Choose your region (Europe, Asia etc.): ' REGION
read -p 'Choose your city (Moscow, New_York): ' CITY

# Symlink timezone file into localtime
ln -sf /usr/share/zoneinfo/$REGION/$CITY /etc/localtime

# Open editor for editing locale.gen
read -p "Choose locale by uncommenting it (press enter to proceed)"
$EDITOR /etc/locale.gen

# Ask user about locale
read -p 'Choose locale you uncommented in /etc/locale.gen (example: en_US.UTF-8): ' LOCALE

# Create locale file
echo $LOCALE > /etc/locale.conf

# Ask user about hostname
read -p 'Enter hostname for your machine (paper-pc):' HOSTNAME

# Create hostname file
echo $HOSTNAME > /etc/hostname

# Add entries to hosts
echo "127.0.0.1	localhost" > /etc/hosts
echo "::1	localhost" > /etc/hosts
echo "127.0.1.1 $HOSTNAME.localdomain $HOSTNAME"

# Ask user for root password
echo 'Set root password: '
passwd root

# Check block device of root
SYSBLK=$(findmnt --raw / | awk '/dev/ {print substr($2,1,length($2)-1)}')

# Check if efi is used to boot
if ls /sys/firmware/efi/efivars
then
	grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
else
	grub-install --target=i386-pc $SYSBLK
fi

# Create new user with group wheel
read -p 'Enter username for user: ' USERNAME
useradd -m -G wheel -s /bin/bash $USERNAME

# Ask user to uncomment certain line in visudo
read -p 'Uncomment ether line 85 or line 82 (Allow members of group wheel to execute any command with or without password)'
visudo
