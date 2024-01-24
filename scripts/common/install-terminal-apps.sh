#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - TERMINAL PROGRAMS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if command -v apt-get > /dev/null; then # Install for debian-based distros
  xargs -a "terminal-apps.txt" sudo apt-get install -y gh fonts-indic fonts-noto-color-emoji python-is-python3
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  xargs -a "terminal-apps.txt" sudo pacman -S --noconfirm github-cli noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-indic-otf
fi

