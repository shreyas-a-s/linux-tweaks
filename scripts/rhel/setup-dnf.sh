#!/usr/bin/env bash

# Check if the OS is RHEL-based
if ! command -v dnf > /dev/null; then
  exit
fi

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - DNF"
fi

# Make dnf faster & more like other package managers
sudo sed -i '/\[main\]/a max_parallel_downloads=5' /etc/dnf/dnf.conf
sudo sed -i '/\[main\]/a defaultyes=True' /etc/dnf/dnf.conf
sudo sed -i '/\[main\]/a keepcache=True' /etc/dnf/dnf.conf

