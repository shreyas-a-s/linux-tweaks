#!/bin/sh

if command -v apt-get > /dev/null; then # Update debian-based distros
  sudo apt-get update && sudo apt-get -y upgrade
fi

