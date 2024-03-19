#!/usr/bin/env bash

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm starship
else # Install for other linux distros
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

