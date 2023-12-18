#!/bin/sh

if command -v apt-get > /dev/null; then
  xargs -a "terminal-apps.txt" sudo apt-get install -y
fi

