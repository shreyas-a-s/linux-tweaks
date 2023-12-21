#!/bin/sh

# Display title of script
if type _printtitle > /dev/null; then
  _printtitle "INSTALLING - VSCODIUM"
fi

if command -v apt-get > /dev/null; then # Install for debian-based distros
  # Add repository
  wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
      | gpg --dearmor \
      | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
  echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
      | sudo tee /etc/apt/sources.list.d/vscodium.list

  # To set third-party repositories to have least priority
  printf "Package: *\
  \nPin: origin download.vscodium.com\
  \nPin-Priority: 100" | sudo tee /etc/apt/preferences.d/vscodium.pref > /dev/null

  # Install the app
  sudo apt-get update
  sudo apt-get -y install codium
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  if command -v yay > /dev/null; then
    yay -S --noconfirm vscodium-bin
  fi
fi

