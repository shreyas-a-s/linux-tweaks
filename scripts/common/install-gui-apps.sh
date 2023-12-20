#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if command -v apt-get > /dev/null; then # Install for debian-based distros
  xargs -a "gui-apps.txt" sudo apt-get install -y python-is-python3
fi

if command -v pacman > /dev/null; then # Install for debian-based distros
  xargs -a "gui-apps.txt" sudo pacman -S --noconfirm
fi

