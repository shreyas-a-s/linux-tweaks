#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - KDECONNECT / GSCONNECT"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if ps -A | grep -q "gnome-shell"; then # Install GSConnect (native kdeconnect implementation for GNOME)
  printf "Installing GSConnect ...\n\n"
  # Install GSconnect dependencies
  if ! command -v openssl > /dev/null; then
    ./install-openssl.sh
  fi
  nohup sh -c 'busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s gsconnect@andyholmes.github.io' > /dev/null 2>&1
else # Install the actual KDEConnect
  if command -v apt-get > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y kdeconnect
  elif command -v pacman > /dev/null; then # Install for archlinux-based distros
    sudo pacman -S --noconfirm kdeconnect
  elif command -v dnf > /dev/null; then # Install for RHEL-based distros
    sudo dnf install -y kde-connect
  fi
fi

