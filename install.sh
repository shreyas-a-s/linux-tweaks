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

# My custom scripts
./scripts/update-system.sh # Updating installed programs
./scripts/install-brave.sh # brave-browser
./scripts/install-essential-apps.sh # As the name suggests
./scripts/github-desktop.sh # github-desktop for linux
./scripts/gnome.sh # GNOME Desktop Environment Customisations
./scripts/nala.sh # apt, but colorful
./scripts/onlyoffice.sh # office suite
./scripts/setup-antix.sh # Antix Linux Customisations
./scripts/setup-bootloader.sh # Bootloader Customisations
./scripts/shell-customization.sh # bash/fish/zsh customizations
./scripts/snap.sh # snap package manager
./scripts/ufw.sh # Install and Setup UFW - The Uncomplicated Firewall
./scripts/vscodium.sh # open source vscode

# Lower swappiness value for better utilization of RAM
sudo sysctl vm.swappiness=10

# Add script to toggle wifi
sudo cp scripts/wifi-toggle.sh /usr/local/bin/wifi-toggle

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
