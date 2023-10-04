#!/bin/bash

# Install flatpak
sudo apt-get -y install flatpak
if [ "$DESKTOP_SESSION" == "gnome" ]; then
	sudo apt-get -y install gnome-software-plugin-flatpak
fi
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Specify the input file
inputfile="flatpak-applist.txt"

# Check if the file exists
if [ -e "$inputfile" ]; then
    packages=""

    while IFS= read -r package; do
        packages="$packages $package"
    done < "$inputfile"

    # Install all packages at once
    flatpak install -y flathub $packages
else
    echo "File does not exist: $inputfile"
fi
