#!/bin/sh

# Exit if NOT gnome
if [ "$XDG_CURRENT_DESKTOP" != "GNOME" ]; then
  echo "This doesn't seem to be a gnome environment." 2>&1
  exit 1
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Uninstall GNOME apps that I don't use
if command -v apt-get > /dev/null; then
  sudo apt-get update
  sudo apt-get -y purge firefox-esr yelp gnome-terminal totem gnome-software gnome-characters gnome-contacts gnome-font-viewer gnome-logs byobu epiphany-browser
  sudo apt-get -y autoremove
fi

# Install GNOME apps that I use
if command -v apt-get > /dev/null; then
  sudo apt-get -y install gnome-console gnome-tweaks fonts-cantarell nautilus baobab gnome-calculator
fi

# Symlink gedit to gnome-text-editor
if [ -f /usr/bin/gnome-text-editor ]; then
  sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit
fi

# Install Rounded Window Corner
busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s rounded-window-corners@yilozt

# Restore dconf settings
dconf load /org/gnome/ < dconf.conf

