#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - AUTO-CPUFREQ"
fi

if ! find /sys/class/power_supply -mindepth 1 -maxdepth 1 -print -quit | grep -q .; then
  printf "\n${BRED}This does't seem like a laptop,${NC} hence not installing auto-cpufreq\n\n" 2>&1
  exit 1
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install auto-cpufreq - For better battery life on laptops
cd ../../.. || exit
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq || exit
sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install

# Install thermald (a program that complements auto-cpufreq)
if command -v apt-get > /dev/null; then # For debian-based distros
  sudo apt-get install -y thermald
elif command -v pacman > /dev/null; then # For archlinux-based distros
  sudo pacman -S --noconfirm thermald
fi

# Enable thermald service
if command -v systemctl > /dev/null; then
  sudo systemctl enable thermald
fi

