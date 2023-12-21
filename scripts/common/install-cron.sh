#!/bin/sh

# Check is cron is already present
if command -v crontab > /dev/null; then
  exit
fi

# Install cron
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y cron
elif command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm cronie
fi

# Enable cron
if command -v systemctl > /dev/null; then
  if systemctl list-unit-files | grep -q cron.service; then
    sudo systemctl enable cron
  elif systemctl list-unit-files | grep -q cronie.service; then
    sudo systemctl enable cronie
  fi
fi

