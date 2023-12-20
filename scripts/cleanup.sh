#!/bin/sh

if command -v apt-get > /dev/null; then # For debian-based distros
  sudo apt-get autoremove -y
fi

