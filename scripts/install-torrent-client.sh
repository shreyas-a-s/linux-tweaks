#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then # Install fragments - Torrent client made for GNOME
  if command -v apt-get > /dev/null && apt-cache search 'fragments' > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y fragments
  else
    ./install-snap.sh
    sudo snap install fragments
  fi
else # Install qbittorrent - Just another torrent client
  if command -v apt-get > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y qbittorrent
  fi
fi

