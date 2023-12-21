#!/bin/sh

# Exit if NOT gnome
if ! ps -A | grep -q "gnome-shell"; then
  printf "\n${BRED}This doesn't seem to be a gnome environment.${NC}\n\n" 2>&1
  exit 1
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install GNOME apps that I use
apps_to_install="gnome-console gnome-tweaks nautilus baobab gnome-calculator gnome-tweaks gnome-control-center gnome-keyring gnome-backgrounds gnome-calculator nautilus qt6-wayland"
if command -v apt-get > /dev/null; then
  apps_to_install="$apps_to_install fonts-cantarell"
  sudo apt-get install -y $apps_to_install
fi
if command -v pacman > /dev/null; then
  apps_to_install="$apps_to_install gdm gvfs-mtp gvfs-gphoto2 cantarell-fonts"
  sudo pacman -S --noconfirm $apps_to_install
fi

# Uninstall GNOME apps that I don't use
apps_to_uninstall="firefox-esr yelp gnome-terminal totem gnome-software gnome-characters gnome-contacts gnome-font-viewer gnome-logs byobu epiphany-browser"
if command -v apt-get > /dev/null; then
  sudo apt-get purge -y $apps_to_uninstall
fi
if command -v pacman > /dev/null; then
  sudo pacman -R --noconfirm $apps_to_uninstall
fi

# Symlink gedit to gnome-text-editor
if [ -f /usr/bin/gnome-text-editor ]; then
  sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit
fi

# Enable gdm if not enabled already
if command -v systemctl > /dev/null; then
  sudo systemctl enable gdm
fi

# Install Rounded Window Corner
busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s rounded-window-corners@yilozt

# Restore dconf settings
dconf load /org/gnome/ < dconf.conf

