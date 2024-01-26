#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - JOPLIN"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  if apt-cache search 'joplin' | cut -d ' ' -f 1 | grep -xq 'joplin'; then
    sudo apt-get install -y joplin
  else
    if ! command -v snap > /dev/null; then
      ./install-snap.sh
    fi
    sudo snap install joplin-desktop
  fi
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  if pacman -Ss joplin-desktop > /dev/null; then
    sudo pacman -S --noconfirm joplin-desktop
  elif command -v yay > /dev/null; then
    yay -S --noconfirm joplin-appimage
  fi
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  if ! command -v snap > /dev/null; then
    ./install-snap.sh
  fi
  sudo snap install joplin-desktop
fi

