#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install neovim
if command -v apt-get > /dev/null; then # Install for debian-based distros
  if apt-cache search 'joplin' | cut -d ' ' -f 1 | grep -q 'joplin'; then
    sudo apt-get install -y joplin-desktop
  else
    if ! command -v snap > /dev/null; then
      ./install-snap.sh
    fi
    sudo snap install joplin-desktop
  fi
fi

