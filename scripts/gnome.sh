#!/bin/sh

# Exit if NOT gnome
echo "$XDG_CURRENT_DESKTOP" | grep GNOME > /dev/null || exit 1

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Begin
sudo apt-get update
sudo apt-get -y purge firefox-esr yelp gnome-terminal totem gnome-software gnome-characters gnome-contacts gnome-font-viewer gnome-logs byobu epiphany-browser kdeconnect keepassxc
sudo apt-get -y install gnome-console gnome-tweaks gnome-text-editor gnome-shell-extension-gsconnect secrets
sudo apt-get -y autoremove

# Symlink gedit to gnome-text-editor
sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit

# Install Rounded Window Corner
busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s rounded-window-corners@yilozt

# Restore dconf settings
dconf load /org/gnome/ < gnome-dconf.conf
