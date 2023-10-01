#!/bin/bash

# Check if script is run as root
if [[ $EUID == 0 ]]; then
  echo "You must NOT be a root user when running this script, please run ./install.sh" 2>&1
  exit 1
fi

# Get debian version & distro name
debianversion=$(cat /etc/debian_version) && debianversion=${debianversion%.*} && export debianversion
distroname=$(awk '{print $1;}' /etc/issue)

# Scripts
function customScripts {
  ./scripts/brave.sh # brave-browser
  ./scripts/flatpak.sh # flatpak and most used apps
  ./scripts/github-desktop.sh # github-desktop for linux
  ./scripts/librewolf.sh # firefox fork that is truely the best (IMO)
  ./scripts/nala.sh # apt, but colorful
  if [ "$qemu_choice" = 'yes' ]; then
    ./scripts/qemu.sh # qemu and virt-manager
  fi
  ./scripts/vscodium.sh # open source vscode
  ./scripts/shell-customization.sh # bash/fish customizations
}

# QEMU Choice
function qemuChoice {
  read -r -p "Continue to install qemu and virt-manager? (yes/no): " qemu_choice
  if [ "$qemu_choice" != 'yes' ] && [ "$qemu_choice" != 'no' ]; then
    echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    qemuChoice
  fi
}

# Shell Choice
function shellChoice {
	read -r -p "Which shell you prefer? (bash/fish) : " shell_choice
  if [ "$shell_choice" != 'bash' ] && [ "$qemu_choice" != 'fish' ]; then
    echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    shellChoice
  fi
}

# Taking user choices
if [ "$customisation_choice" != 'yes' ]; then
  qemuChoice
  shellChoice && export shell_choice
fi

# Updating system & installing programs
echo ""; echo "Doing a system update & Installing required programs..."
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install ufw man trash-cli git htop neofetch gparted micro tldr keepassxc vlc shellcheck fzf curl wget python-is-python3

# My custom scripts
customScripts

# Installing an AppImage(Joplin) dependency that is not pre-installed in antix inux
if [ "$distroname" == "Antix" ]; then
	sudo apt-get -y install libnss3
fi

# Enabling firewall
sudo ufw enable

# updating tldr pages
tldr -u

# Change Grub Timeout
sudo sed -i "/GRUB_TIMEOUT/ c\GRUB_TIMEOUT=2" /etc/default/grub
sudo update-grub

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
