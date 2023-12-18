#!/bin/sh

# Update debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get update && sudo apt-get -y upgrade
fi

