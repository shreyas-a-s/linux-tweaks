#!/usr/bin/env bash

# Check if the OS is RHEL-based
if ! command -v dnf > /dev/null; then
  exit
fi

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - DNF"
fi

# Increase maximum number of simultaneous package downloads
if grep -q max_parallel_downloads /etc/dnf/dnf.conf; then
  sudo sed -i '/max_parallel_downloads/c max_parallel_downloads=5' /etc/dnf/dnf.conf
else
  sudo sed -i '/\[main\]/a max_parallel_downloads=5' /etc/dnf/dnf.conf
fi

# Assume Yes where it would normally prompt for user confirmation ([Y/n] instead of [y/N])
if grep -q defaultyes /etc/dnf/dnf.conf; then
  sudo sed -i '/defaultyes/c defaultyes=True' /etc/dnf/dnf.conf
else
  sudo sed -i '/\[main\]/a defaultyes=True' /etc/dnf/dnf.conf
fi

# Keeps downloaded packages in the cache
if grep -q keepcache /etc/dnf/dnf.conf; then
  sudo sed -i '/keepcache/c keepcache=True' /etc/dnf/dnf.conf
else
  sudo sed -i '/\[main\]/a keepcache=True' /etc/dnf/dnf.conf
fi

