#!/bin/sh

if command -v apt-get > /dev/null && apt-cache search nala | cut -d ' ' -f 1 | grep -xq 'nala'; then
  sudo apt-get -y install nala
fi

