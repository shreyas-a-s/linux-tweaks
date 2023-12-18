#!/bin/sh

# Check if snap is already installed
if command -v snap > /dev/null; then
  echo "Error: snap is already installed at $(command -v snap)" 2>&1
  exit 1
fi

# Install snapd
if command -v apt-get > /dev/null; then
  sudo apt-get update && sudo apt-get install -y snapd
fi

# Install snap apps that I use
sudo snap install joplin-desktop

