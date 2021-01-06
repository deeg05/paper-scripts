#!/bin/sh

#
# Basic installation of Paper Linux
#

# Install userspace, kernel, firmware and text editor
pacstrap /mnt base linux linux-firmware man man-pages nvim nano ed grub sudo
# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab
# Copy paper scripts from installation media
cp -r /paper /mnt/
# Chroot into newly created installation
arch-chroot /mnt
