#!/bin/bash

# Check if script is run as root
if [[ $EUID == 0 ]]; then
  echo "You must NOT be a root user when running this script, please run ./install.sh" 2>&1
  exit 1
fi

# Get username, working directory path, debian version & distro name
username=$(id -u -n 1000)
builddir=$(pwd)
debianversion=$(cat /etc/debian_version) && debianversion=${debianversion%.*}
distroname=$(awk '{print $1;}' < /etc/issue)

# Updating system & installing programs
echo ""; echo "Doing a system update & Installing required programs..."
sudo apt update && sudo apt upgrade -y
sudo apt install pcmanfm man trash-cli htop neofetch gparted micro tldr keepassxc fonts-indic vlc gcc git galculator autojump zsync shellcheck tar bzip2 unrar gzip unzip p7zip-full zstd bat diffutils ntfs-3g dosfstools e2fsprogs exfatprogs mtools -y
./scripts/install-librewolf.sh # librewolf, a firefox fork that runs quite better on debian than firefox-esr
./scripts/install-am-joplin.sh # joplin, a note taking app
. ./scripts/install-lsd.sh # lsd (the next-gen 'ls' command)
./scripts/install-lite-xl.sh # A text editor that replaced geany for mel

# Installing a Joplin dependency that is not pre-installed in antix inux
if [ "$distroname" == "Antix" ]; then
	sudo apt install libnss3 -y
fi

# Creating necessary directories
echo ""; echo "Making required directories..."
mkdir -p ~/.config/lscolors/
mkdir -p ~/.local/share/fonts/
sudo mkdir -p /root/.local/share/tldr/

# Enter the arena
cd "$builddir" || exit

# Copy config files
echo ""; echo "Copying config files, fonts and rebuilding font cache..."
cp dotfiles/lscolors.csh ~/.config/lscolors/ # Adding some spash of colors to the good old ls command
cp dotfiles/CodeNewRomanNerdFontMono-Regular.otf ~/.local/share/fonts/ && fc-cache -vf # Adding my fav terminal font & rebuilding font cache
if test -f ~/.config/qtile/config.py; then
	sed -i "s/--hide-scrollbar/--hide-scrollbar --font=\"CodeNewRoman Nerd Font Mono Regular 11\"/g" ~/.config/qtile/config.py # Setting termial font in qtile to automatically be my fav one
fi
if test -f ~/.config/i3/config; then
	sed -i "s/--hide-scrollbar/--hide-scrollbar --font=\"CodeNewRoman Nerd Font Mono Regular 11\"/g" ~/.config/i3/config # Setting termial font in i3 to automatically be my fav one
fi

# Some tweaks
echo ""; echo "Settting swappiness..."; echo "vm.swappiness=1
vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf > /dev/null # to decrease swap usage
./scripts/ssd-health.sh # for SSD health
. ./scripts/install-shell-customization.sh # bash/fish customizations
sudo sed -i "/GRUB_TIMEOUT/ c\GRUB_TIMEOUT=0" /etc/default/grub
sudo sed -i "s/quiet/quiet video=1366x768/" /etc/default/grub
tldr -u && sudo tldr -u # updating tldr pages for normal and root user
sudo update-grub # grub tweaks (nothing major)

# Setting wallpaper
echo ""; echo "Setting my favorite wallpaper..."
nitrogen --set-zoom-fill /usr/share/backgrounds/garden.jpg --save

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
