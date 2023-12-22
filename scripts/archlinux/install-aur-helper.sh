#!/usr/bin/env bash

# Check if the OS is Arch Linux
if ! command -v pacman > /dev/null; then
  exit
fi

# Display title of script
if type _printtitle > /dev/null; then
  _printtitle "INSTALLING - AUR HELPER"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install yay - AUR helper
cd ../../.. || exit
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin || exit
makepkg -si --noconfirm
yay -Y --gendb

