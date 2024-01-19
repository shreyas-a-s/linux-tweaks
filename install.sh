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

# Take user choice
choices=$(whiptail --title "USER CHOICE" --checklist "      Choose one or more options:" 15 43 8 \
    0  "Select All" OFF \
    1  "Install AutoCPUFreq" OFF \
    2  "Install Brave Browser" OFF \
    3  "Install Cron" OFF \
    4  "Install Github Desktop" OFF \
    5  "Install GUI Apps" OFF \
    6  "Install Joplin" OFF \
    7  "Install KDE/GSConnect" OFF \
    8  "Install OnlyOffice" OFF \
    9  "Install Password Manager  " OFF \
    10 "Install Terminal Tweaks" OFF \
    11 "Install Torrect Client" OFF \
    12 "Install UFW" OFF \
    13 "Install VSCodium" OFF \
    14 "Setup Bluetooth" OFF \
    15 "Setup Bootloader" OFF \
    16 "Setup GNOME" OFF \
    17 "Setup Multi-Audio" OFF \
    2>&1 >/dev/tty)

# Exit if user choses 'Cancel'
exitstatus=$?
if [ $exitstatus = 1 ]; then
  exit 1
fi

# Convert choices variable into an array
eval "c_array=($choices)"

# Add all options to array if user did select 'Select All' in whiptail checklist
if _is_element_of_array c_array[@] 0; then
  c_array=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17")
fi

# My custom scripts
./scripts/archlinux/install-aur-helper.sh      # Program that helps install packages from AUR (the user contributed arch linux repository)
./scripts/archlinux/install-paccache.sh        # Program that helps clear pacman cache in archlinux
./scripts/archlinux/setup-pacman.sh            # Make arch package manager work better
./scripts/common/update-system.sh              # Updating installed programs
_is_element_of_array c_array[@] 1  && ./scripts/common/install-auto-cpufreq.sh       # Automatically change cpu freq to save battery
_is_element_of_array c_array[@] 2  && ./scripts/common/install-brave.sh              # My fav browser
_is_element_of_array c_array[@] 3  && ./scripts/common/install-cron.sh               # Program to automate tasks
_is_element_of_array c_array[@] 4  && ./scripts/common/install-github-desktop.sh     # Github-desktop for linux
_is_element_of_array c_array[@] 5  && ./scripts/common/install-gui-apps.sh           # GUI apps common to all default package managers
_is_element_of_array c_array[@] 6  && ./scripts/common/install-joplin.sh             # Cloud-synced note-taking app
_is_element_of_array c_array[@] 7  && ./scripts/common/install-kde-or-gsconnect.sh   # connect phone to computer for copy pasting files & text
_is_element_of_array c_array[@] 8  && ./scripts/common/install-onlyoffice.sh         # Office suite
_is_element_of_array c_array[@] 9  && ./scripts/common/install-passwd-manager.sh     # As name suggests
_is_element_of_array c_array[@] 10 && ./scripts/common/install-terminal-tweaks.sh    # Some customizations to make my terminal experience better
_is_element_of_array c_array[@] 11 && ./scripts/common/install-torrent-client.sh     # Also, as name suggests
_is_element_of_array c_array[@] 12 && ./scripts/common/install-ufw.sh                # Install and Setup UFW - The Uncomplicated Firewall
_is_element_of_array c_array[@] 13 && ./scripts/common/install-vscodium.sh           # Open source vscode
_is_element_of_array c_array[@] 14 && ./scripts/common/setup-bluetooth.sh            # Bluetooth tweaks
_is_element_of_array c_array[@] 15 && ./scripts/common/setup-bootloader.sh           # Bootloader Customisations
_is_element_of_array c_array[@] 16 && ./scripts/common/setup-gnome.sh                # GNOME Desktop Environment Customisations
_is_element_of_array c_array[@] 17 && ./scripts/common/setup-multi-audio.sh          # Enable audio routed to multiple devices at same time
./scripts/common/cleanup.sh                    # Cleanup package manager cache
./scripts/debian/install-nala.sh               # Good old apt, but colorful
./scripts/debian/setup-antix.sh                # Antix Linux Customisations

# Custom tweaks
sudo sysctl vm.swappiness=10                             # Lower swappiness value for better utilization of RAM
sudo cp ./bin/wifi-toggle.sh /usr/local/bin/wifi-toggle  # Script to toggle wifi

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
