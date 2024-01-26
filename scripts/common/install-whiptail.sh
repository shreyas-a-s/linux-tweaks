#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - WHIPTAIL"
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get install -y whiptail
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --no-confirm whiptail
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y newt
fi

