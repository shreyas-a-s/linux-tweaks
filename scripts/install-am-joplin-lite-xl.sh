#!/bin/bash

wget https://raw.githubusercontent.com/ivan-hc/APPLICATION-MANAGER/main/INSTALL
chmod a+x ./INSTALL
sudo ./INSTALL
rm -rf INSTALL
sudo am -i joplin lite-xl
