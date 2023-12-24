#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - MULTI DEVICE AUDIO"
fi

### Installs programs to enable routing audio to multiple devices simultaneousily ###

if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y pipewire-jack qjackctl
elif command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm pipewire-jack qjackctl
fi

