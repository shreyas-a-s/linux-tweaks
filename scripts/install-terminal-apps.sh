#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if command -v apt-get > /dev/null; then
  xargs -a "terminal-apps.txt" sudo apt-get install -y
fi

