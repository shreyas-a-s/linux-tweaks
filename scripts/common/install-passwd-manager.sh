#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - PASSWORD MANAGER"
fi

if ps -A | grep -q "gnome-shell"; then # Install secrets (password manager for GNOME)
  if command -v apt-get > /dev/null; then
    sudo apt-get install -y secrets
  elif command -v pacman > /dev/null; then
    sudo pacman -S --noconfirm secrets
  elif command -v dnf > /dev/null; then
    sudo dnf install -y secrets
  fi
else # Install Keepassxc (another password manager)
  if command -v apt-get > /dev/null; then
    sudo apt-get install -y keepassxc
  elif command -v pacman > /dev/null; then
    sudo pacman -S --noconfirm keepassxc
  elif command -v dnf > /dev/null; then
    sudo dnf install -y keepassxc
  fi
fi
