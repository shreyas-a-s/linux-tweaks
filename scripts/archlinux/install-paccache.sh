#!/usr/bin/env bash

# Check if the OS is Arch Linux
if ! command -v pacman > /dev/null; then
  exit
fi

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - PACCACHE"
fi

# Install pacman-contrib meta-package that contains paccache program
sudo pacman -S --noconfirm pacman-contrib

# Make pacman hooks directory if not present already
if ! [ -d /etc/pacman.d/hooks ]; then
  sudo mkdir -p /etc/pacman.d/hooks
fi

# Enable auto clearing pacman cache using paccache program
echo "[Trigger]                              
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Package
Target = *
[Action]
Description = Cleaning pacman cache...
When = PostTransaction
Exec = /usr/bin/paccache -rk1" | sudo tee /etc/pacman.d/hooks/clean-pkg-cache.hook > /dev/null

