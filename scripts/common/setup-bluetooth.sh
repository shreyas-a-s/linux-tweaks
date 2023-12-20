#!/bin/sh

# Install bluetooth packages
if command -v apt-get > /dev/null; then
  sudo apt install -y bluez
elif command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm bluez bluez-hid2hci
fi

# Make connecting to bluetooth sound devices better
sudo sed "/FastConnectable/ c\FastConnectable = true" /etc/bluetooth/main.conf

# Enable kernel bluetooth module if not already enabled
if ! lsmod | grep -q btusb; then
  sudo modprobe btusb
fi

# Enable bluetooth service if not already enabled
if command -v systemctl > /dev/null; then
  sudo systemctl enable bluetooth
fi

