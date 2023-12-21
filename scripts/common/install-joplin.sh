#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install neovim
if command -v apt-get > /dev/null; then # Install for debian-based distros
  if apt-cache search 'joplin' | cut -d ' ' -f 1 | grep -q 'joplin'; then
    sudo apt-get install -y joplin
  else
    if ! command -v snap > /dev/null; then
      ./install-snap.sh
    fi
    sudo snap install joplin-desktop
  fi
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  if pacman -Ss joplin-desktop > /dev/null; then
    sudo pacman -S --noconfirm joplin-desktop
  elif command -v yay > /dev/null; then
    yay -S --noconfirm joplin-appimage
  fi
fi

