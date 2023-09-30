#!/bin/bash

# Install flatpak
sudo apt-get -y install flatpak
if [ "$DESKTOP_SESSION" == "gnome" ]; then
	sudo apt-get -y install gnome-software-plugin-flatpak
fi
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Specify the input file
if test -f "./scripts/flatpak-applist.txt"; then
    inputfile="./scripts/flatpak-applist.txt"
else
    inputfile="./flatpak-applist.txt"
fi

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
    flatpak install -y flathub $packages
else
    echo "File does not exist: $inputfile"
fi
