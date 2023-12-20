#!/bin/sh

# Exit if NOT gnome
if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
  printf "\n${BRED}This doesn't seem to be a gnome environment.${NC}\n\n" 2>&1
  exit 1
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install GNOME apps that I use
apps_to_install="gnome-console gnome-tweaks fonts-cantarell nautilus baobab gnome-calculator"
if command -v apt-get > /dev/null; then
  sudo apt-get install -y $apps_to_install
fi
if command -v pacman > /dev/null; then
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

# Install Rounded Window Corner
busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s rounded-window-corners@yilozt

# Restore dconf settings
dconf load /org/gnome/ < dconf.conf

