#!/bin/bash

# Install flatpak
sudo apt-get -y install flatpak
if [ "$DESKTOP_SESSION" == "gnome" ] && dpkg-query -l | grep gnome-software &> /dev/null; then
	sudo apt-get -y install gnome-software-plugin-flatpak
fi
while ! flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo; do
    sleep 1
done

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

echo 'XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"' >> ~/.config/user-dirs.dirs
xdg-user-dirs-update
