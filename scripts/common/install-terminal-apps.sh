#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - TERMINAL PROGRAMS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  xargs -a "../../components/terminal-apps.txt" sudo apt-get install -y gh python-is-python3 fd-find
  sudo ln -sf "$(which fdfind)" "$(dirname "$(which fdfind)")" # Symlink fd -> fdfind
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  xargs -a "../../components/terminal-apps.txt" sudo pacman -S --noconfirm github-cli fd
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  xargs -a "../../components/terminal-apps.txt" sudo dnf install -y gh fd-find
fi

