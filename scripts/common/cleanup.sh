#!/bin/sh

if command -v apt-get > /dev/null; then # For debian-based distros
  sudo apt-get autoremove -y
fi

# Add a cron-job to auto clear trash
echo "@reboot $USER /usr/bin/find /home/$USER/.local/share/Trash/ -mtime +7 -delete" | sudo tee /etc/cron.d/auto-trash-empty > /dev/null

