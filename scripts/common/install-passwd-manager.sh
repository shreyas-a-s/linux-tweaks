#!/bin/sh

if ps -A | grep -q "gnome-shell"; then # Install secrets (password manager for GNOME)
  if command -v apt-get > /dev/null; then
    sudo apt-get install -y secrets
  elif command -v pacman > /dev/null; then
    sudo pacman -S --noconfirm secrets
  fi
else # Install Keepassxc (another password manager)
  if command -v apt-get > /dev/null; then
    sudo apt-get install -y keepassxc
  elif command -v pacman > /dev/null; then
    sudo pacman -S --noconfirm keepassxc
  fi
fi
