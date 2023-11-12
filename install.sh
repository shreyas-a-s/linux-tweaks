#!/bin/sh

# ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗       ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗
# ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║      ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║
# ██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║█████╗██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║
# ██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║╚════╝██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║
# ██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║      ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║██╗
# ╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝       ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝

# Check if script is run as root
if [ "$(id -u)" -eq 0 ]; then
  echo "You must NOT be a root user when running this script, please run ./install.sh" 2>&1
  exit 1
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Variables
distroname=$(awk '{print $1;}' /etc/issue)

# Scripts
customScripts() {
  ./scripts/brave.sh # brave-browser
  ./scripts/flatpak.sh # flatpak and most used apps
  ./scripts/github-desktop.sh # github-desktop for linux
  ./scripts/librewolf.sh # firefox fork that is truely the best (IMO)
  ./scripts/nala.sh # apt, but colorful
  ./scripts/onlyoffice.sh # office suite
  if [ "$qemu_choice" = 'yes' ]; then
    ./scripts/qemu.sh # qemu and virt-manager
  fi
  ./scripts/vscodium.sh # open source vscode
  ./scripts/shell-customization.sh # bash/fish customizations
}

# QEMU Choice
qemuChoice() {
  echo "Continue to install qemu and virt-manager? (yes/no): " && read -r qemu_choice
  if [ "$qemu_choice" != 'yes' ] && [ "$qemu_choice" != 'no' ]; then
    printf "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    qemuChoice
  fi
}

# Shell Choice
shellChoice() {
	echo "Which shell you prefer to customise?"
	echo "[1] Bash"
	echo "[2] Fish"
	echo "[3] Zsh"
	echo "[4] None"
	echo "Choose an option (1/2/3/4) : " && read -r shell_choice
  if ! [ "$shell_choice" -ge 1 ] || ! [ "$shell_choice" -le 4 ]; then
    printf "Invalid Choice..!!!\n\n"
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
sudo apt-get -y install ufw man git gparted vlc shellcheck curl wget python-is-python3 obs-studio

# Don't install kdeconnect & keepassxc on GNOME
if dpkg-query -l | grep gnome > /dev/null; then
	sudo apt-get -y install secrets
else
  sudo apt-get -y install kdeconnect keepassxc
fi

# My custom scripts
customScripts

# Installing an AppImage(Joplin) dependency that is not pre-installed in antix inux
if [ "$distroname" = "Antix" ]; then
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
