#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - GRAPHICAL APPS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  xargs -a "../../components/gui-apps.txt" sudo apt-get install -y
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  xargs -a "../../components/gui-apps.txt" sudo pacman -S --noconfirm qt6-wayland
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  xargs -a "../../components/gui-apps.txt" sudo dnf install -y
fi

