#!/bin/sh

# Check if the OS is Arch Linux
if ! command -v pacman > /dev/null; then
  exit
fi

# Install yay - AUR helper
cd ../../.. || exit
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin || exit
makepkg -si
yay -Y --gendb

