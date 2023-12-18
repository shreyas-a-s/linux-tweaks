#!/bin/sh
# Install for debian-based distros
if command -v apt-get > /dev/null; then
  sudo apt-get update
  sudo apt-get install -y wget
  wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
  # To set third-party repositories to have least priority
  echo 'Package: *\
  \nPin: origin apt.packages.shiftkey.dev\
  \nPin-Priority: 100' | sudo tee /etc/apt/preferences.d/shiftkey.pref > /dev/null
  sudo apt-get update
  sudo apt-get -y install github-desktop
fi
