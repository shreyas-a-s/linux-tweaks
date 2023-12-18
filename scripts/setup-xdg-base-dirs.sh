#!/bin/sh

# Define an array of programs
xdg_programs=("xdg-user-dirs" "xdg-desktop-portal")

# Add xdg-desktop-portal-gnome if gnome is detected
if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  xdg_programs+=("xdg-desktop-portal-gnome")
fi

# Install xdg apps
if command -v apt-get > /dev/null; then
  sudo apt-get install -y "${xdg_programs[@]}"
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
cp user-dirs.dirs ~/.config/
xdg-user-dirs-update
rm -d ~/desktop ~/music ~/templates ~/public
