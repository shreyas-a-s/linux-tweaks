#!/bin/bash

# Variables
debianversion=$(awk -F '.' '{print $1}' < /etc/debian_version)

# Install
if [ "$debianversion" -ge 12 ]; then
    sudo apt-get -y install nala
fi