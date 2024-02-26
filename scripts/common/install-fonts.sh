#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - FONTS"
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get install -y fonts-indic fonts-noto-color-emoji
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-indic-otf
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y google-noto-cjk-fonts google-noto-emoji-fonts google-noto-sans-malayalam-fonts
fi

