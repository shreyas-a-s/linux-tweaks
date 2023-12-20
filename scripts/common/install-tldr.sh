#!/bin/sh

if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y tldr
fi

tldr -u # Update tldr database

