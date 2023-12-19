#!/bin/sh

if command -v apt-get > /dev/null; then # for debian-based distros
  sudo apt-get autoremove -y
fi

