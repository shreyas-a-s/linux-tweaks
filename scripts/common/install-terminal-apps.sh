#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - TERMINAL PROGRAMS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  xargs -a "../../components/terminal-apps.txt" sudo apt-get install -y gh fonts-indic fonts-noto-color-emoji python-is-python3
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  xargs -a "../../components/terminal-apps.txt" sudo pacman -S --noconfirm github-cli noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-indic-otf
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  xargs -a "../../components/terminal-apps.txt" sudo dnf install -y gh google-noto-cjk-fonts google-noto-emoji-fonts
fi

