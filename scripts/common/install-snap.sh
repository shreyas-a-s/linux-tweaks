#!/usr/bin/env bash

# Check if snap is already installed
if command -v snap > /dev/null; then
  printf "\n${BRED}Error: snap is already installed at${NC} $(command -v snap)\n" 2>&1
  exit 1
fi

# Install snapd
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y snapd
elif command -v yay > /dev/null; then # Install for archlinux-based distros
  yay -S --noconfirm snapd
elif command -v dnf > /dev/null; then # Install for RHEL-based distros
  sudo dnf install -y snapd
fi

