#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - NIXOS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Backup current nixos config file
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration-"$(date '+%Y%m%d%H%M%S')".nix

# Copy our new nixos config file
sudo cp ../../components/configuration.nix /etc/nixos/configuration.nix

# Rebuild the system configuration
sudo nixos-rebuild switch --log-format bar-with-logs

# Install Gnome Extensions
printf "\nInstalling GSConnect ...\n"
nohup sh -c 'busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s gsconnect@andyholmes.github.io' > /dev/null 2>&1
printf "\nInstalling Rounded Window Corners ...\n"
nohup sh -c 'busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s rounded-window-corners@yilozt' > /dev/null 2>&1

# Restore dconf backup
dconf load /org/gnome/ < ../common/dconf.conf

# Set wallpaper in Gnome
mkdir -p ~/.local/share/backgrounds/gnome
cp ../../components/keys-l.jpg ../../components/keys-d.jpg ~/.local/share/backgrounds/gnome/
dconf write /org/gnome/desktop/background/picture-uri "\"file://$HOME/.local/share/backgrounds/gnome/keys-d.jpg\""
dconf write /org/gnome/desktop/background/picture-uri-dark "\"file://$HOME/.local/share/backgrounds/gnome/keys-l.jpg\""

# Reclaiming disk space using Nix garbage collector
sudo nix-collect-garbage

# Optimise nix-store
printf "\nOptimising nix-store. Please wait ...\n"
sleep 2
sudo nix-store --optimise

# Update tldr database
tldr -u

# Add wifi-toggle script to system programs
nix-env -if ../../components/wifi-toggle.nix

# Setup XDG User Directories
../common/setup-xdg-base-dirs.sh

