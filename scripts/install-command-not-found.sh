#!/bin/sh

if command -v apt-get > /dev/null; then
  sudo apt-get install -y command-not-found
  # Update database of command-not-found
  sudo update-command-not-found
  sudo apt-get update
fi
