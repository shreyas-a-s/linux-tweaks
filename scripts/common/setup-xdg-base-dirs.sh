#!/bin/sh

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Define a string of programs
xdg_programs="xdg-user-dirs xdg-desktop-portal"

# Add xdg-desktop-portal-gnome if gnome is detected
if ps -A | grep -q "gnome-shell"; then
  xdg_programs="$xdg_programs xdg-desktop-portal-gnome"
fi

# Install xdg apps
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y $xdg_programs
fi
if command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm $xdg_programs
fi

# Function to setup XDG user dirs
setupXDGUserDirs() {

  for dirname in "$@"; do
    newdirname="$(echo "$dirname" | awk '{print tolower($0)}')"

    if [ -d "$dirname" ]; then
      mv "$dirname" "$newdirname"
    else
      mkdir "$newdirname"
    fi
  done

}

# Actual setup
setupXDGUserDirs ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public

# Assign new values to xdg user directories
cp user-dirs.dirs ~/.config/

# Update the list of values
xdg-user-dirs-update

# Remove directories that I don't use
rm -d ~/desktop ~/music ~/templates ~/public

