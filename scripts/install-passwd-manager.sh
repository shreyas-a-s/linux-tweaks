#!/bin/sh

if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  if command -v apt-get > /dev/null; then
    sudo apt-get install -y secrets
  fi
else
  if command -v apt-get > /dev/null; then
    sudo apt-get install -y keepassxc
  fi
fi
