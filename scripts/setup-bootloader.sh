#!/bin/sh

# Change Grub Timeout
if [ -f /etc/default/grub ]; then
  sudo sed -i "/GRUB_TIMEOUT/ c\GRUB_TIMEOUT=2" /etc/default/grub
  sudo update-grub
fi

# Change systemd-boot Timeout
if [ -f /boot/loader/loader.conf ]; then
  sudo sed -i "/timeout/ c\timeout 1" /boot/loader/loader.conf
fi

