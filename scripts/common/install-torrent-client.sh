#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - TORRENT CLIENT"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if pgrep -f "gnome-shell" > /dev/null; then # Install fragments - Torrent client made for GNOME
  if command -v apt-get > /dev/null; then # Install for debian-based distros
    if apt-cache search 'fragments' | cut -d ' ' -f 1 | grep -xq 'fragments'; then
      sudo apt-get install -y fragments
    else
      if ! command -v snap > /dev/null; then
        ./install-snap.sh
      fi
      sudo snap install fragments
    fi
  elif command -v pacman > /dev/null; then # Install for archlinux-based distros
    sudo pacman -S --noconfirm fragments
  elif command -v dnf > /dev/null; then # Install for RHEL-based distros
    sudo dnf install -y fragments
  fi
else # Install qbittorrent - Just another torrent client
  if command -v apt-get > /dev/null; then # Install for debian-based distros
    sudo apt-get install -y qbittorrent
  elif command -v pacman > /dev/null; then # Install for archlinux-based distros
    sudo pacman -S --noconfirm qbittorrent
  elif command -v dnf > /dev/null; then # Install for RHEL-based distros
    sudo dnf install -y qbittorrent
  fi
fi

