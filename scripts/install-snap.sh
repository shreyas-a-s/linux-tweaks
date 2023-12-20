#!/bin/sh

# Check if snap is already installed
if command -v snap > /dev/null; then
  printf "${BRED}Error: snap is already installed at${NC} $(command -v snap)\n" 2>&1
  exit 1
fi

# Install snapd
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get update && sudo apt-get install -y snapd
fi

