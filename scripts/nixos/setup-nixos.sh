#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - NIXOS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Backup current nixos config file
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.nix.bak

# Copy our new nixos config file
sudo cp ../../components/configuration.nix /etc/nixos/configuration.nix

# Rebuild the system configuration
sudo nixos-rebuild switch --log-format bar-with-logs

# Reclaiming disk space using Nix garbage collector
sudo nix-collect-garbage

# Optimise nix-store
sudo nix-store --optimise

# Add wifi-toggle script to system programs
nix-env -iA ../../components/wifi-toggle.nix

