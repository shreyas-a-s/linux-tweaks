#!/bin/bash
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
# To set third-party repositories to have least priority
echo -e 'Package: *\nPin: origin download.vscodium.com\nPin-Priority: 100' | sudo tee /etc/apt/preferences.d/vscodium.pref > /dev/null
sudo apt-get update && sudo apt-get -y install codium