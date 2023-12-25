#!/usr/bin/env bash

# Check if the OS is Debian-based
if ! command -v apt-get > /dev/null; then
  exit
fi

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - NALA"
fi

# Install the program
if apt-cache search nala | cut -d ' ' -f 1 | grep -xq 'nala'; then
  sudo apt-get -y install nala
fi

