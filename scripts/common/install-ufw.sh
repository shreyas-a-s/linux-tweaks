#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - UFW"
fi

# Install ufw
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y ufw
elif command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm ufw
elif command -v dnf > /dev/null; then # Install for RHEL-based distros
  sudo dnf install -y ufw
fi

# Add default rules
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Enable ufw service
if ! sudo ufw enable; then
  if command -v systemctl > /dev/null; then
    sudo systemctl enable ufw
  fi
fi

# Add rules to allow kdeconnect to work properly
if command -v kdeconnect-cli > /dev/null || gnome-extensions list | grep -q gsconnect; then
  sudo ufw allow 1714:1764/udp
  sudo ufw allow 1714:1764/tcp
  sudo ufw reload
fi



