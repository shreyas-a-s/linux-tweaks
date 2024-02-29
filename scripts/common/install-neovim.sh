#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "INSTALLING - NEOVIM"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Install dependencies
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y gcc ripgrep xsel fd-find python3-venv
  sudo ln -sf "$(which fdfind)" "$(dirname "$(which fdfind)")" # Symlink fd -> fdfind
elif command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm gcc ripgrep xsel fd python-virtualenv
elif command -v dnf > /dev/null; then # Install for RHEL-based distros
  sudo dnf install -y gcc ripgrep xsel fd-find python3-virtualenv
fi

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  if [ "$(apt-cache show neovim | grep Version | awk -F '.' '{print $2}')" -ge 9 ]; then
    sudo apt-get install -y neovim
  else
    if ! command -v snap > /dev/null; then
      ./install-snap.sh
    fi
    sudo snap install nvim 2>/dev/null || sudo snap install nvim --classic
    sudo ln -s /snap/bin/nvim /usr/local/bin/
  fi
fi

# Install for archlinux-based distros
if command -v pacman > /dev/null; then
  sudo pacman -S --noconfirm neovim
fi

# Install for RHEL-based distros
if command -v dnf > /dev/null; then
  sudo dnf install -y neovim
fi

