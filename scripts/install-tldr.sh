#!/bin/sh

if command -v apt-get > /dev/null; then
  sudo apt-get install -y tldr
fi

tldr -u

