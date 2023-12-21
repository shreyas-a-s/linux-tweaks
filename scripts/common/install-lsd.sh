#!/bin/sh

if command -v apt-get > /dev/null && apt-cache show lsd > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y lsd
elif command -v dpkg > /dev/null; then
  wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
  sudo dpkg -i lsd_0.23.1_amd64.deb
  rm lsd_0.23.1_amd64.deb
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm lsd
fi

