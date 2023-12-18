#!/bin/sh

if command -v apt-get > /dev/null; then
  xargs -a "essential-apps.txt" sudo apt-get install -y python-is-python3
fi

