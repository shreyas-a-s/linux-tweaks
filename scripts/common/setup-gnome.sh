#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - GNOME"
fi

# Exit if NOT gnome
if ! ps -A | grep -q "gnome-shell"; then
  printf "\n${BRED}This doesn't seem to be a gnome environment.${NC}\n" 2>&1
  exit 1
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install GNOME apps that I use
if command -v apt-get > /dev/null; then
  xargs -a "../../components/gnome-apps-to-install.txt" sudo apt-get install -y fonts-cantarell gdm3
elif command -v pacman > /dev/null; then
  xargs -a "../../components/gnome-apps-to-install.txt" sudo pacman -S --noconfirm cantarell-fonts gdm gvfs-gphoto2 gvfs-mtp
elif command -v dnf > /dev/null; then
  xargs -a "../../components/gnome-apps-to-install.txt" sudo dnf install -y abattis-cantarell-fonts gdm gvfs-gphoto2 gvfs-mtp
fi

# Uninstall GNOME apps that I don't use
if command -v apt-get > /dev/null; then
  xargs -a "../../components/gnome-apps-to-remove.txt" sudo apt-get purge -y
elif command -v pacman > /dev/null; then
  xargs -a "../../components/gnome-apps-to-remove.txt" sudo pacman -R --noconfirm
elif command -v dnf > /dev/null; then
  xargs -a "../../components/gnome-apps-to-remove.txt" sudo dnf remove -y
fi

# Symlink gedit to gnome-text-editor
if [ -f /usr/bin/gnome-text-editor ]; then
  sudo ln -s /usr/bin/gnome-text-editor /usr/bin/gedit
fi

# Enable GDM - GNOME Display Manager
if command -v systemctl > /dev/null; then
  if systemctl list-unit-files | grep -q gdm.service; then
    sudo systemctl enable gdm
  elif systemctl list-unit-files | grep -q gdm3.service; then
    sudo systemctl enable gdm3
  fi
fi

# Install Rounded Window Corners
printf "Installing gnome extension - rounded window corners ...\n\n"
nohup sh -c 'busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s rounded-window-corners@yilozt' > /dev/null 2>&1

# Restore dconf settings
dconf load /org/gnome/ < ../../components/dconf.conf

