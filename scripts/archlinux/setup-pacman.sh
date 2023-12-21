#!/bin/sh

# Check if the OS is Arch Linux
if ! command -v pacman > /dev/null; then
  exit
fi

# Make output of pacman better
sudo sed -i '/Color/c Color' /etc/pacman.conf
sudo sed -i '/VerbosePkgLists/c VerbosePkgLists' /etc/pacman.conf
sudo sed -i '/ParallelDownloads/c ParallelDownloads = 5' /etc/pacman.conf
sudo sed -i '/ParallelDownloads/a ILoveCandy' /etc/pacman.conf

