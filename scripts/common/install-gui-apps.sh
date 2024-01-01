#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - GRAPHICAL APPS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if command -v apt-get > /dev/null; then # Install for debian-based distros
  xargs -a "gui-apps.txt" sudo apt-get install -y
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  xargs -a "gui-apps.txt" sudo pacman -S --noconfirm qt6-wayland
fi

