#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - ONLYOFFICE"
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  # Add repository
  mkdir -p -m 700 ~/.gnupg
  gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
  chmod 644 /tmp/onlyoffice.gpg
  sudo chown root:root /tmp/onlyoffice.gpg
  sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg
  echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list

  # To set third-party repositories to have least priority
  printf "Package: *
  Pin: origin download.onlyoffice.com
  Pin-Priority: 100" | sudo tee /etc/apt/preferences.d/onlyoffice.pref > /dev/null

  # Install the app
  sudo apt-get update
  sudo apt-get -y install onlyoffice-desktopeditors
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  if pacman -Ss onlyoffice-desktopeditors > /dev/null; then
    sudo pacman -S --noconfirm onlyoffice-desktopeditors
  elif command -v yay > /dev/null; then
    yay -S --noconfirm onlyoffice-bin
  fi
fi

# Install for RHEL-based distros
if command -v yum > /dev/null; then
  sudo yum install -y https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
  sudo yum install -y onlyoffice-desktopeditors
fi

