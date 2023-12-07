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
distroname=$(awk '{print $1}' /etc/issue)

# Updating system & installing programs
echo ""; echo "Doing a system update & Installing required programs..."
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install ufw man git gparted vlc shellcheck curl wget python-is-python3 obs-studio kdeconnect keepassxc qbittorrent

# My custom scripts
./scripts/brave.sh # brave-browser
./scripts/github-desktop.sh # github-desktop for linux
./scripts/gnome.sh # gnome-specific-customisations
./scripts/librewolf.sh # firefox fork that is truely the best (IMO)
./scripts/nala.sh # apt, but colorful
./scripts/onlyoffice.sh # office suite
./scripts/snap.sh # snap package manager
./scripts/vscodium.sh # open source vscode
./scripts/shell-customization.sh # bash/fish/zsh customizations

# Installing an AppImage(Joplin) dependency that is not pre-installed in antix inux
[ "$distroname" = "Antix" ] && sudo apt-get -y install libnss3

# Enabling firewall
sudo ufw enable
if command -v kdeconnect-cli > /dev/null || gnome-extensions list | grep -q gsconnect; then
  sudo ufw allow 1714:1764/udp
  sudo ufw allow 1714:1764/tcp
  sudo ufw reload
fi

# Change Grub Timeout
sudo sed -i "/GRUB_TIMEOUT/ c\GRUB_TIMEOUT=2" /etc/default/grub
sudo update-grub

# Lower swappiness value for better utilization of RAM
sudo sysctl vm.swappiness=10

# Add script to toggle wifi
echo "#!/bin/sh

if [ $(rfkill list wifi | grep "Soft blocked: yes" | wc -l) -gt 0 ] ; then
  rfkill unblock wifi
else
  rfkill block wifi
fi" | sudo tee /usr/local/bin/wifi-toggle
sudo chmod +x /usr/local/bin/wifi-toggle

# Done
echo "Installation is complete. Reboot your system for the changes to take place."
