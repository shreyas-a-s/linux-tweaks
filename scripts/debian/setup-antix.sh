#!/bin/sh

# Check if the OS is Antix Linux
if [ "$(awk '{print $1}' /etc/issue)" != "Antix" ]; then
  exit
fi

# Installing an AppImage(Joplin) dependency that is not pre-installed in antix inux
sudo apt-get -y install libnss3

