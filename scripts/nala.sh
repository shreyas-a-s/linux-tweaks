#!/bin/bash

# Variables
debianversion=$(cat /etc/debian_version | awk -F '.' '{print $1}')

# Install
if [ "$debianversion" -ge 12 ]; then
    sudo apt-get -y install nala
fi