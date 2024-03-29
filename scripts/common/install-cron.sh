#!/usr/bin/env bash

# Check is cron is already present
if command -v crontab > /dev/null; then
  exit
fi

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - CRON"
fi

# Install cron
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y cron
elif command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm cronie
elif command -v dnf > /dev/null; then # Install for RHEL-based distros
  sudo dnf install -y cronie
fi

# Enable cron
if command -v systemctl > /dev/null; then
  if systemctl list-unit-files | grep -q cron.service; then
    sudo systemctl enable cron
  elif systemctl list-unit-files | grep -q cronie.service; then
    sudo systemctl enable cronie
  fi
fi

