#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - XDG BASE DIRECTORY"
fi

# Function to setup XDG user dirs
function _setup_xdg_user_dirs {

  for dirname in "$@"; do
    newdirname="$(echo "$dirname" | awk '{print tolower($0)}')"

    if [ -d "$dirname" ]; then
      mv "$dirname" "$newdirname"
    else
      mkdir "$newdirname"
    fi
  done

}

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Define an array of programs
xdg_programs=('xdg-user-dirs' 'xdg-desktop-portal')

# Add xdg-desktop-portal-gnome if gnome is detected
if pgrep -f "gnome-shell" > /dev/null; then
  xdg_programs+=('xdg-desktop-portal-gnome')
fi

# Install xdg apps
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y "${xdg_programs[@]}"
elif command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm "${xdg_programs[@]}"
elif command -v dnf > /dev/null; then # Install for RHEL-based distros
  sudo dnf install -y "${xdg_programs[@]}"
fi

# Actual setup
echo "Renaming directories in home folder ..."
_setup_xdg_user_dirs ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public

# Assign new values to xdg user directories
cp ../../components/user-dirs.dirs ~/.config/

# Update the list of values
xdg-user-dirs-update

# Remove directories that I don't use
rm -d ~/desktop ~/music ~/templates ~/public

