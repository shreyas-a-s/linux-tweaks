#!/usr/bin/env bash

# Display title of script
if type _printtitle > /dev/null; then
  _printtitle "INSTALLING - KDECONNECT / GSCONNECT"
fi

if ps -A | grep -q "gnome-shell"; then # Install GSConnect (native kdeconnect implementation for GNOME)
  nohup sh -c 'busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s gsconnect@andyholmes.github.io' > /dev/null 2>&1
else # Install the actual KDEConnect
  if command -v apt-get > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y kdeconnect
  elif command -v pacman > /dev/null; then # Install for archlinux-based distros
    sudo pacman -S --noconfirm kdeconnect
  fi
fi

