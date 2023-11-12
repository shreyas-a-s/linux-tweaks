#!/bin/sh
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
# To set third-party repositories to have least priority
echo 'Package: *
Pin: origin apt.packages.shiftkey.dev
Pin-Priority: 100' | sudo tee /etc/apt/preferences.d/shiftkey.pref > /dev/null
sudo apt-get update && sudo apt-get -y install github-desktop
