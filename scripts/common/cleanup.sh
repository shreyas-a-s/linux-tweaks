#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "CLEANING UP"
fi

# For debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get autoremove -y
fi

# For archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -Scc --noconfirm # Empty pacman cache
  if command -v yay > /dev/null; then
    yay -Scc --noconfirm # Empty aur package cache
  fi
fi

# For RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf autoremove -y
fi

# Add a cron-job to auto clear trash
echo "@reboot $USER /usr/bin/find /home/$USER/.local/share/Trash/ -mtime +7 -delete" | sudo tee /etc/cron.d/auto-trash-empty > /dev/null

