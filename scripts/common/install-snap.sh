#!/usr/bin/env bash

# Display title of script
if type _printtitle > /dev/null; then
  _printtitle "INSTALLING - SNAP"
fi

# Check if snap is already installed
if command -v snap > /dev/null; then
  printf "\n${BRED}Error: snap is already installed at${NC} $(command -v snap)\n" 2>&1
  exit 1
fi

# Install snapd
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y snapd
fi
if command -v yay > /dev/null; then # Install for archlinux-based distros
  yay -S --noconfirm snapd
fi

