#!/usr/bin/env bash

# ██╗     ██╗███╗   ██╗██╗   ██╗██╗  ██╗  ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
# ██║     ██║████╗  ██║██║   ██║╚██╗██╔╝  ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
# ██║     ██║██╔██╗ ██║██║   ██║ ╚███╔╝█████╗██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
# ██║     ██║██║╚██╗██║██║   ██║ ██╔██╗╚════╝██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
# ███████╗██║██║ ╚████║╚██████╔╝██╔╝ ██╗     ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
# ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝     ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

# Display a title in terminal
if [ -f ./main-title.sh ]; then
  ./main-title.sh
fi

# Source colors
if [ -f ./colors.sh ]; then
  . ./colors.sh
fi

# Check if script is run as root
if [ "$(id -u)" -eq 0 ]; then
  printf "\n${BRED}You must NOT be a root user when running this script,${NC} please run ./install.sh as normal user\n\n" 2>&1
  exit 1
fi

# Source functions
if [ -d ./functions ]; then
  for fn in ./functions/*; do
    . "$fn"
  done
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# My custom scripts
./scripts/archlinux/install-aur-helper.sh      # Program that helps install packages from AUR (the user contributed arch linux repository)
./scripts/archlinux/install-paccache.sh        # Program that helps clear pacman cache in archlinux
./scripts/archlinux/setup-pacman.sh            # Make arch package manager work better
./scripts/common/update-system.sh              # Updating installed programs
./scripts/common/install-auto-cpufreq.sh       # Automatically change cpu freq to save battery
./scripts/common/install-brave.sh              # My fav browser
./scripts/common/install-cron.sh               # Program to automate tasks
./scripts/common/install-github-desktop.sh     # Github-desktop for linux
./scripts/common/install-gui-apps.sh           # GUI apps common to all default package managers
./scripts/common/install-joplin.sh             # Cloud-synced note-taking app
./scripts/common/install-kde-or-gsconnect.sh   # connect phone to computer for copy pasting files and command and more
./scripts/common/install-onlyoffice.sh         # Office suite
./scripts/common/install-passwd-manager.sh     # As name suggests
./scripts/common/install-torrent-client.sh     # Also, as name suggests
./scripts/common/install-ufw.sh                # Install and Setup UFW - The Uncomplicated Firewall
./scripts/common/install-vscodium.sh           # Open source vscode
./scripts/common/setup-bluetooth.sh            # Bluetooth tweaks
./scripts/common/setup-bootloader.sh           # Bootloader Customisations
./scripts/common/setup-gnome.sh                # GNOME Desktop Environment Customisations
./scripts/common/setup-multi-audio.sh          # Enable audio to be routed to multiple devices simultaneosuily
./scripts/common/shell-customization.sh        # Shell (bash/fish/zsh) customizations
./scripts/common/cleanup.sh                    # Cleanup package manager cache
./scripts/debian/install-nala.sh               # Good old apt, but colorful
./scripts/debian/setup-antix.sh                # Antix Linux Customisations

# Custom tweaks
sudo sysctl vm.swappiness=10                             # Lower swappiness value for better utilization of RAM
sudo cp ./bin/wifi-toggle.sh /usr/local/bin/wifi-toggle  # Script to toggle wifi

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
