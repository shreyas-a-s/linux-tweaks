#!/bin/sh

# Display title of script
if type _printtitle > /dev/null; then
  _printtitle "INSTALLING - TLDR"
fi

if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y tldr
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm tldr
fi

tldr -u # Update tldr database

