#!/bin/sh
if [ "$1" = "intel" ]
then
	echo 'Installing intel graphics'
	pacman -S xf86-video-intel mesa
elif [ "$1" = "nvidia" ]
then
	echo 'Installing proprietary nvidia graphics'
	pacman -S nvidia nvidia-utils
elif [ "$1" = "noveau" ]
then
	echo 'Installing free nvidia graphics '
	pacman -S xf86-video-noveau mesa
elif [ "$1" = "ati" ]
then
	echo 'Installing free ATI graphics'
	pacman -S xf86-video-ati mesa
elif [ "$1" = "amdgpu" ]
then
	echo 'Installing free AMD graphics'
	pacman -S xf86-video-amdgpu mesa
elif [ "$1" = "amdpro" ]
then
 	echo 'Installing proprietary AMD OpenGL'
	yay -S xf86-video-amdgpu amdgpu-pro-libgl
elif [ "$1" = "fbdev" ]
then
	echo "Installing fbdev graphics (no acceleration!)"
	pacman -S xf86-video-fbdev
elif [ "$1" = "vesa" ]
then
	echo "Installing vesa graphics (no acceleration!)"
	pacman -S xf86-video-vesa
else
	echo "Please specify graphics driver (intel, nvidia, noveau, ati, amdgpu, amdpro, fbdev, vesa)"
fi
