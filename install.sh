#!/bin/bash

# Check if script is run as root
if [[ $EUID == 0 ]]; then
  echo "You must NOT be a root user when running this script, please run ./install.sh" 2>&1
  exit 1
fi

# Functions
function choiceOfQemu {
   read -r -p "Continue to install qemu and virt-manager? (yes/no): " choice
   case "$choice" in 
     "yes" ) echo "Starting the installation.."; (cd .. && git clone https://github.com/shreyas-a-s/debian-qemu.git && cd debian-qemu/ && ./install.sh);;
     "no" ) exit 1;;
     * ) echo "Invalid Choice! Keep in mind this is CASE-SENSITIVE."; choiceOfQemu;;
   esac
}

# Get working directory, debian version & distro name
builddir=$(pwd)
debianversion=$(cat /etc/debian_version) && debianversion=${debianversion%.*} && export debianversion
distroname=$(awk '{print $1;}' /etc/issue)

# Updating system & installing programs
echo ""; echo "Doing a system update & Installing required programs..."
sudo apt update && sudo apt upgrade -y
sudo apt install ufw man trash-cli git bat htop neofetch gparted micro tldr keepassxc vlc autojump shellcheck fzf -y
./scripts/brave.sh # brave-browser
./scripts/flatpak.sh # flatpak and most used apps
./scripts/github-desktop.sh # github-desktop for linux
./scripts/librewolf.sh # firefox fork that is truely the best (IMO)
./scripts/lsd.sh # lsd (the next-gen 'ls' command)
./scripts/nala.sh # apt, but colorful
./scripts/vscodium.sh # open source vscode

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

# updating tldr pages
tldr -u

# Installing qemu and virt-manager
choiceOfQemu

# Change Grub Timeout
sudo sed -i "/GRUB_TIMEOUT/ c\GRUB_TIMEOUT=2" /etc/default/grub
sudo update-grub

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
