#!/usr/bin/env bash

# Display title of script
if type _printtitle > /dev/null; then
  _printtitle "UPDATING SYSTEM"
fi

if command -v apt-get > /dev/null; then # Update debian-based distros
  sudo apt-get update && sudo apt-get -y upgrade
fi

if command -v pacman > /dev/null; then # Update archlinux-based distros
  sudo pacman -Syu --noconfirm
fi

if command -v yay > /dev/null; then # Update aur packages in archlinux if present
  yay -Syu --noconfirm
fi

