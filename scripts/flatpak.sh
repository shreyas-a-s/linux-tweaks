#!/bin/bash

# Install flatpak
sudo apt install flatpak -y
if [ "$DESKTOP_SESSION" == "gnome" ]; then
	sudo apt install gnome-software-plugin-flatpak -y
fi
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Specify the input file
inputfile="./scripts/flatpak-applist.txt" || inputfile="./flatpak-applist.txt"

# Check if the file exists
if [ -e "$inputfile" ]; then
    # Initialize a variable to store package names separated by spaces
    packages=""

    # Read each line from the file and accumulate the package names
    while IFS= read -r package; do
        # Add the package name to the list with a space
        packages="$packages $package"
    done < "$inputfile"

    # Install all packages at once
    flatpak install flathub $packages -y
else
    echo "File does not exist: $inputfile"
fi
