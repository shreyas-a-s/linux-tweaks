#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install gcc which is a dependancy of a neovim plugin
sudo apt-get update && sudo apt-get install -y gcc

# Install neovim
if [ "$(apt-cache show neovim | grep Version | awk -F '.' '{print $2}')" -ge 9 ]; then
  sudo apt-get install -y neovim
else
  if ! command -v snap > /dev/null; then
    sudo apt-get install -y snapd
  fi
  sudo snap install nvim 2>/dev/null || sudo snap install nvim --classic
  sudo ln -s /snap/bin/nvim /usr/local/bin/
fi
