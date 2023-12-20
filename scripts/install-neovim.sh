#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install dependencies
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get update
  sudo apt-get install -y gcc xsel
fi

# Install neovim
if command -v apt-get > /dev/null && [ "$(apt-cache show neovim | grep Version | awk -F '.' '{print $2}')" -ge 9 ]; then # Install for debian-based distros
  sudo apt-get install -y neovim
else
  if ! command -v snap > /dev/null; then
    ./install-snap.sh
  fi
  sudo snap install nvim 2>/dev/null || sudo snap install nvim --classic
  sudo ln -s /snap/bin/nvim /usr/local/bin/
fi
