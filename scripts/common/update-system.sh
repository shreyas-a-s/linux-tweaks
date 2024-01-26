#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "UPDATING SYSTEM"
fi

# Update debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get update && sudo apt-get -y upgrade
fi

# Update archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -Syu --noconfirm
fi

# Update aur packages in archlinux if present
if command -v yay > /dev/null; then
  yay -Syu --noconfirm
fi

# Update RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf upgrade -y
fi

