#!/bin/bash

wget -q -nv -O - https://api.github.com/repos/lite-xl/lite-xl/releases/latest   | awk -F': ' '/browser_download_url/ && /\.tar.gz/ \
 {gsub(/"/, "", $(NF)); system("wget -qi -L " $(NF))}'
tar -xzf *-addons-linux-x86_64-portable.tar.gz
sudo mkdir -p /usr/share/lite-xl/
sudo cp lite-xl/lite-xl /usr/bin/
sudo cp -r lite-xl/data/* /usr/share/lite-xl/
sudo cp dotfiles/lite-xl.desktop /usr/share/applications/
sudo cp litexl.svg /usr/share/pixmaps/
rm -r lite-xl/ *.gz
