#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - VSCODIUM"
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
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

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  if command -v yay > /dev/null; then
    yay -S --noconfirm vscodium-bin
  fi
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
  printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
  sudo dnf install -y codium
fi

