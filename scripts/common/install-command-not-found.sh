#!/bin/sh

if command -v apt-get > /dev/null; then # Install for debian-based distros
  # Install the app
  sudo apt-get install -y command-not-found

  # Update database of command-not-found
  sudo update-command-not-found
  sudo apt-get update
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  # Install the app
  sudo pacman -S --noconfirm pkgfile

  # Update database of pkgfile
  sudo pkgfile -u
fi

