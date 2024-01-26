#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - BRAVE BROWSER"
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  # Add repository
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

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  if pacman -Ss brave-browser > /dev/null; then
    sudo pacman -S --noconfirm brave-browser
  elif command -v yay > /dev/null; then
    yay -S --noconfirm brave-bin
  fi
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y dnf-plugins-core
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  sudo dnf install -y brave-browser
fi

