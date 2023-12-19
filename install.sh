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
./scripts/update-system.sh              # Updating installed programs
./scripts/install-brave.sh              # My fav browser
./scripts/install-essential-apps.sh     # As the name suggests
./scripts/install-github-desktop.sh     # Github-desktop for linux
./scripts/install-kde-or-gsconnect.sh   # connect phone to computer for copy pasting files and command and more
./scripts/install-nala.sh               # Good old apt, but colorful
./scripts/install-onlyoffice.sh         # Office suite
./scripts/install-passwd-manager.sh     # As name suggests
./scripts/install-torrent-client.sh     # Also, as name suggests
./scripts/install-ufw.sh                # Install and Setup UFW - The Uncomplicated Firewall
./scripts/install-vscodium.sh           # Open source vscode
./scripts/setup-antix.sh                # Antix Linux Customisations
./scripts/setup-bootloader.sh           # Bootloader Customisations
./scripts/setup-gnome.sh                # GNOME Desktop Environment Customisations
./scripts/shell-customization.sh        # Shell (bash/fish/zsh) customizations

# Custom tweaks
sudo sysctl vm.swappiness=10                               # Lower swappiness value for better utilization of RAM
sudo cp scripts/wifi-toggle.sh /usr/local/bin/wifi-toggle  # Script to toggle wifi

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
