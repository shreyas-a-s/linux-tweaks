#!/bin/sh

# Check if the OS is Debian-based
if ! command -v apt-get > /dev/null; then
  exit
fi

# Install the program
if apt-cache search nala | cut -d ' ' -f 1 | grep -xq 'nala'; then
  sudo apt-get -y install nala
fi

