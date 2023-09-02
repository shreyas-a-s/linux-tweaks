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
distroname=$(awk '{print $1;}' /etc/issue)

# Updating system & installing programs
echo ""; echo "Doing a system update & Installing required programs..."
sudo apt update && sudo apt upgrade -y
sudo apt install ufw man trash-cli git bat htop neofetch gparted micro tldr keepassxc vlc autojump shellcheck fzf -y
./scripts/librewolf.sh # librewolf, a firefox fork that runs quite better on debian than firefox-esr
./scripts/brave.sh # install brave-browser
./scripts/flatpak-apps.sh # install flatpak and most used apps
./scripts/github-desktop.sh # github-desktop for linux
./scripts/vscodium.sh # open source vs-code
. ./scripts/nala.sh # the better apt command
. ./scripts/lsd.sh # lsd (the next-gen 'ls' command)

# Installing an AppImage(Joplin) dependency that is not pre-installed in antix inux
if [ "$distroname" == "Antix" ]; then
	sudo apt install libnss3 -y
fi

# Enabling firewall
sudo ufw enable

# Enter the arena
cd "$builddir" || exit

# Some tweaks
. ./scripts/shell-customization.sh # bash/fish customizations
tldr -u # updating tldr pages

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
