#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - COMMAND-NOT-FOUND HANDLER"
fi

if command -v apt-get > /dev/null; then # Install for debian-based distros
  # Install the app & dependencies
  sudo apt-get install -y command-not-found apt-file

  # Update database of command-not-found
  sudo update-command-not-found
  sudo apt-file update
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  # Install the app
  sudo pacman -S --noconfirm pkgfile

  # Update database of pkgfile
  sudo pkgfile -u
fi

