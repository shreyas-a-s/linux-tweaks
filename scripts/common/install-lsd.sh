#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - LSDELUXE"
fi

# Install for debian-based distros
if command -v apt-get > /dev/null && apt-cache search lsd | cut -d ' ' -f 1 | grep -xq 'lsd'; then
  sudo apt-get install -y lsd
elif command -v dpkg > /dev/null; then
  wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
  sudo dpkg -i lsd_0.23.1_amd64.deb
  rm lsd_0.23.1_amd64.deb
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm lsd
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y lsd
fi

