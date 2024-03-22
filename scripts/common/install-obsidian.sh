#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - OBSIDIAN"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  if apt-cache show obsidian 2>/dev/null; then
    sudo apt-get install -y obsidian
  else
    if ! command -v snap > /dev/null; then
      ./install-snap.sh
    fi
    sudo snap install obsidian 2>/dev/null || sudo snap install obsidian --classic
  fi
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm obsidian
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  if dnf search obsidian 2> /dev/null; then
    sudo dnf install -y obsidian
  else
    if ! command -v snap > /dev/null; then
      ./install-snap.sh
    fi
    sudo snap install obsidian 2>/dev/null || sudo snap install obsidian --classic
  fi
fi

