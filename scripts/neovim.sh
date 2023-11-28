#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if [ "$(apt-cache show neovim | grep Version | awk -F '.' '{print $2}')" -ge 9 ]; then
  sudo apt-get install -y neovim
else
  if ! which snap > /dev/null; then
    sudo apt install -y snapd
  fi
  sudo snap install nvim 2>/dev/null || sudo snap install nvim --classic
fi
