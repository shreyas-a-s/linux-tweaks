#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install gcc which is a dependancy of a neovim plugin
if command -v apt-get > /dev/null; then
  sudo apt-get update
  sudo apt-get install -y gcc
fi

# Install neovim
if [ "$(apt-cache show neovim | grep Version | awk -F '.' '{print $2}')" -ge 9 ]; then
  sudo apt-get install -y neovim
else
  ./install-snap.sh
  sudo snap install nvim 2>/dev/null || sudo snap install nvim --classic
  sudo ln -s /snap/bin/nvim /usr/local/bin/
fi
