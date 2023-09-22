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
./scripts/brave.sh # install brave-browser
./scripts/flatpak.sh # install flatpak and most used apps
./scripts/github-desktop.sh # github-desktop for linux
./scripts/librewolf.sh # firefox fork that si truely the best (IMO)
./scripts/vscodium.sh # open source vscode
. ./scripts/nala.sh # the better apt command
./scripts/lsd.sh # lsd (the next-gen 'ls' command)

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

# Installing qemu and virt-manager
choiceOfQemu

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
