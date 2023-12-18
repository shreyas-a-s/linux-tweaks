#!/bin/sh

if apt-cache show nala > /dev/null; then
  sudo apt-get -y install nala
fi

