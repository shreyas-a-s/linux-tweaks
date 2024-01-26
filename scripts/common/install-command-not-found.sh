#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - COMMAND-NOT-FOUND HANDLER"
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  # Install the app & dependencies
  sudo apt-get install -y command-not-found apt-file

  # Update database of command-not-found
  sudo update-command-not-found
  sudo apt-file update
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  # Install the app
  sudo pacman -S --noconfirm pkgfile

  # Update database of pkgfile
  sudo pkgfile -u
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y PackageKit-command-not-found
fi

