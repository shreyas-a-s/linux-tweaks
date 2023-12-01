#!/bin/sh

# Exit if NOT gnome
echo "$XDG_CURRENT_DESKTOP" | grep GNOME > /dev/null || exit 1

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Begin
sudo apt-get update
sudo apt-get -y purge firefox-esr yelp gnome-terminal totem gnome-software gnome-characters gnome-contacts gnome-font-viewer gnome-logs byobu epiphany-browser kdeconnect keepassxc
sudo apt-get -y install gnome-console gnome-tweaks gnome-text-editor secrets fonts-cantarell nautilus baobab gnome-calculator
sudo apt-get -y autoremove

# Symlink gedit to gnome-text-editor
sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit

# Install Rounded Window Corner
busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s rounded-window-corners@yilozt

# Install GSConnect
busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s gsconnect@andyholmes.github.io

# Uninstall qbittorrent if present
command -v qbittorrent > /dev/null && sudo apt purge -y qbittorrent

# Install fragments - bittorrent client
command -v snap > /dev/null || sudo apt install -y snapd
sudo snap install fragments

# Restore dconf settings
dconf load /org/gnome/ < gnome-dconf.conf
