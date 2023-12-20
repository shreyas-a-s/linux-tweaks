#!/bin/sh

# ██████╗ ███████╗██████╗ ██╗ █████╗ ███╗   ██╗       ██████╗██╗   ██╗███████╗████████╗ ██████╗ ███╗   ███╗
# ██╔══██╗██╔════╝██╔══██╗██║██╔══██╗████╗  ██║      ██╔════╝██║   ██║██╔════╝╚══██╔══╝██╔═══██╗████╗ ████║
# ██║  ██║█████╗  ██████╔╝██║███████║██╔██╗ ██║█████╗██║     ██║   ██║███████╗   ██║   ██║   ██║██╔████╔██║
# ██║  ██║██╔══╝  ██╔══██╗██║██╔══██║██║╚██╗██║╚════╝██║     ██║   ██║╚════██║   ██║   ██║   ██║██║╚██╔╝██║
# ██████╔╝███████╗██████╔╝██║██║  ██║██║ ╚████║      ╚██████╗╚██████╔╝███████║   ██║   ╚██████╔╝██║ ╚═╝ ██║██╗
# ╚═════╝ ╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝       ╚═════╝ ╚═════╝ ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝

# Source colors
. ./colors.sh

# Check if script is run as root
if [ "$(id -u)" -eq 0 ]; then
  printf "\n${BRED}You must NOT be a root user when running this script,${NC} please run ./install.sh as normal user\n" 2>&1
  exit 1
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# My custom scripts
./scripts/common/update-system.sh              # Updating installed programs
./scripts/common/install-brave.sh              # My fav browser
./scripts/common/install-gui-apps.sh           # GUI apps common to all default package managers
./scripts/common/install-github-desktop.sh     # Github-desktop for linux
./scripts/common/install-kde-or-gsconnect.sh   # connect phone to computer for copy pasting files and command and more
./scripts/common/install-onlyoffice.sh         # Office suite
./scripts/common/install-passwd-manager.sh     # As name suggests
./scripts/common/install-torrent-client.sh     # Also, as name suggests
./scripts/common/install-ufw.sh                # Install and Setup UFW - The Uncomplicated Firewall
./scripts/common/install-vscodium.sh           # Open source vscode
./scripts/common/setup-bootloader.sh           # Bootloader Customisations
./scripts/common/setup-gnome.sh                # GNOME Desktop Environment Customisations
./scripts/common/shell-customization.sh        # Shell (bash/fish/zsh) customizations
./scripts/common/cleanup.sh                    # Cleanup package manager cache
./scripts/debian/install-nala.sh               # Good old apt, but colorful
./scripts/debian/setup-antix.sh                # Antix Linux Customisations

# Custom tweaks
sudo sysctl vm.swappiness=10                             # Lower swappiness value for better utilization of RAM
sudo cp ./bin/wifi-toggle.sh /usr/local/bin/wifi-toggle  # Script to toggle wifi

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
