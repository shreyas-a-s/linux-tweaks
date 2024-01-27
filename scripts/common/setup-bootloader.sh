#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - BOOTLOADER"
fi

# Change Grub Timeout
if [ -f /etc/default/grub ]; then
  sudo sed -i "/GRUB_TIMEOUT/ c\GRUB_TIMEOUT=1" /etc/default/grub
  if command -v grub-mkconfig > /dev/null; then
    sudo grub-mkconfig -o /boot/grub/grub.cfg
  elif command -v grub2-mkconfig > /dev/null; then
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
  fi
fi

# Change systemd-boot Timeout
if [ -f /boot/loader/loader.conf ]; then
  sudo sed -i "/timeout/ c\timeout 1" /boot/loader/loader.conf
fi

