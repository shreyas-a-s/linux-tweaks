#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - GITHUB DESKTOP"
fi

if command -v apt-get > /dev/null; then # Install for debian-based distros
  # Add repository
  sudo apt-get install -y wget
  wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'

  # To set third-party repositories to have least priority
  printf "Package: *\
  \nPin: origin apt.packages.shiftkey.dev\
  \nPin-Priority: 100" | sudo tee /etc/apt/preferences.d/shiftkey.pref > /dev/null

  # Install the app
  sudo apt-get update
  sudo apt-get -y install github-desktop
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  if pacman -Ss github-desktop > /dev/null; then
    sudo pacman -S --noconfirm github-desktop
  elif command -v yay > /dev/null; then
    yay -S --noconfirm github-desktop-bin
  fi
fi

