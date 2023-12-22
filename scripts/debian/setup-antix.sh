#!/usr/bin/env bash

# Check if the OS is Antix Linux
if [ "$(awk '{print $1}' /etc/issue)" != "Antix" ]; then
  exit
fi

# Display title of script
if type _printtitle > /dev/null; then
  _printtitle "SETTING UP - ANTIX LINUX"
fi

# Installing an AppImage(Joplin) dependency that is not pre-installed in antix inux
sudo apt-get -y install libnss3

