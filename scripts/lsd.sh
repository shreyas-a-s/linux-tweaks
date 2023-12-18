#!/bin/sh

if apt-cache show lsd > /dev/null; then
  sudo apt-get install -y lsd
elif command -v dpkg > /dev/null; then
  wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
  sudo dpkg -i lsd_0.23.1_amd64.deb
  rm lsd_0.23.1_amd64.deb
fi
