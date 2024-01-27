#!/usr/bin/env bash

# Check if openssl is already installed
if command -v openssl > /dev/null; then
  printf "\n${BRED}Error: openssl is already installed at${NC} $(command -v openssl)\n" 2>&1
  exit 1
fi

# Install openssl
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y openssl
elif command -v yay > /dev/null; then # Install for archlinux-based distros
  yay -S --noconfirm openssl
elif command -v dnf > /dev/null; then # Install for RHEL-based distros
  sudo dnf install -y openssl
fi

