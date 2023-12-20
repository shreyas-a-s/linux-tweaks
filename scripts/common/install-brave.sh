#!/bin/sh

if command -v apt-get > /dev/null; then # Install for debian-based distros
  # Add repository
  sudo apt-get update
  sudo apt-get -y install curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
  
  # To set third-party repositories to have least priority
  printf "Package: *\
  \nPin: origin brave-browser-apt-release.s3.brave.com\
  \nPin-Priority: 100" | sudo tee /etc/apt/preferences.d/brave.pref > /dev/null
  
  # Install the app
  sudo apt-get update
  sudo apt-get -y install brave-browser
fi

if command -v pacman > /dev/null; then # Install for archlinux-based distros
  if pacman -Ss brave-browser > /dev/null; then
    sudo pacman -S --noconfirm brave-browser
  elif command -v yay > /dev/null; then
    yay -S brave-bin
  fi
fi

