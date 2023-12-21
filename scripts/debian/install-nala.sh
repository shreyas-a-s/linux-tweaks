#!/bin/sh

if command -v apt-get > /dev/null && apt-cache show nala > /dev/null; then
  sudo apt-get -y install nala
fi

