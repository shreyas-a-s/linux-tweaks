#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  if apt-cache show fragments > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y fragments
  else
    ./install-snap.sh
    sudo snap install fragments
  fi
else
  if command -v apt-get > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y qbittorrent
  fi
fi

