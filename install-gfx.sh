#!/bin/bash

#
# Paper Linux
# Install base programs
#

if [[ $EUID -ne 0 ]]; then
	read -p "This script will install basic paper linux programs"
else
	echo "You must be non-root user"
	exit 1
fi

# Ask user about non-root stuff
read -p "Please use this script only as non-root user!"

# Install basic X packages
echo "Installing basic X and other packages"
sudo pacman -S xorg-server xorg-apps xorg-xinit bspwm sxhkd xscreensaver termite python3 python-pip mate-polkit lxappearance
pip install pywal 

# Ask user about init
if [read -p "Would you like to use plain xinit or lightdm? (default xinit) " = "lightdm" ]
then
	sudo pacman -S lightdm lightdm-gtk-greeter xorg-xinit
else
	sudo pacman -S xorg-xinit
fi

# Ask user what videodrivers he/she wants to install
read -p "What graphic drivers to install? (intel, nvid    ia, noveau, ati, amdgpu, amdpro, fbdev, vesa)" VIDEODRV
sudo /paper/scripts/install-video.sh $VIDEODRV

# Create .local/src directory and go into it
mkdir ~/.local/src && cd ~/.local/src

# Install git and base-devel (dependencies of yay)
echo "Installing yay dependencies"
sudo pacman -S --needed git base-devel

echo "Cloning yay repo off of github"
git clone https://aur.archlinux.org/yay.git
cd yay
echo "Installing yay"
makepkg -si

# Install aur packages
echo "Installing AUR-only packages (could take some time)"
yay -S polybar picom-ibhagwan-git nerd-fonts-hack

# Install Deeg05's dmenu fork
cd ~/.local/src
git clone https://github.com/deeg05/dmenu
cd dmenu
sudo make install

# Install dotfiles
cd ~/.local/src
git clone https://github.com/deeg05/dotfiles
# Check python version
PYVER=$(python3 --version | awk '{print substr($2,1,length($2)-2)}')
cp ~/.local/src/dotfiles/.local/lib/pythonX.X/site-packages/pywal/templates/colors.Xresources ~/.local/lib/python$PYVER/site-packages/pywal/templates/
cp ~/.local/src/dotfiles ~/.config/
cp ~/.local/src/bin ~/.local/

echo "export PATH=$PATH:/.local/src/bin" >> ~/.bashrc
echo "exec bspwm" > ~/.xinitrc
