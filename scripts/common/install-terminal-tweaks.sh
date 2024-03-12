#!/usr/bin/env bash

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# My custom scripts
./install-command-not-found.sh  # Command-not-found handler
./install-lsd.sh                # LSDeluxe - the fancy ls command
./install-neovim.sh             # Best text editor in the world ;-)
./install-starship.sh           # Minimal, infinitely customizable prompt for any shell
./install-terminal-apps.sh      # Terminal apps that I use
./install-tldr.sh               # Man pages, but simpler to understand
./setup-sudoers.sh              # Apply custom tweaks to sudoers file
./setup-user-shell.sh           # Apply customisations to user shell (bash/fish/zsh)
./setup-xdg-base-dirs.sh        # Setup XDG Base Directories

