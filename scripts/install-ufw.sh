#!/bin/sh

# Install ufw
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y ufw
fi

# Enable ufw service
sudo ufw enable
if [ "$?" -ne 0 ]; then
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



