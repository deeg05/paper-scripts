#!/bin/sh

#
# Basic installation of Paper Linux
#

# Install userspace, kernel, firmware and text editor
pacstrap /mnt base linux linux-firmware man man-pages neovim nano ed grub sudo networkmanager
# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab
# Copy paper scripts from installation media
cp -r /paper /mnt/
# Set TERM variable since we're chrooting into system without termite
export TERM=xterm-256color
# Chroot into newly created installation
arch-chroot /mnt
