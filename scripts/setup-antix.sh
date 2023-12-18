#!/bin/sh

# Variables
distro_name=$(awk '{print $1}' /etc/issue)

# Installing an AppImage(Joplin) dependency that is not pre-installed in antix inux
if [ "$distro_name" = "Antix" ]; then
  sudo apt-get -y install libnss3
fi

