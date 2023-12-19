#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

if command -v apt-get > /dev/null; then

  xargs -a "essential-apps.txt" sudo apt-get install -y python-is-python3
fi

