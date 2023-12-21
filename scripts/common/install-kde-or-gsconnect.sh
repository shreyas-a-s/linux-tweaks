#!/bin/sh

if ps -A | grep -q "gnome-shell"; then
  busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s gsconnect@andyholmes.github.io
else
  if command -v apt-get > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y kdeconnect
  elif command -v pacman > /dev/null; then # Install for archlinux-based distros
    sudo pacman -S --noconfirm kdeconnect
  fi
fi

