#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "APPLY - SHELL CUSTOMISATIONS"
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Taking shell choice
while true; do
  echo "Which shell you prefer?"
  echo "[1] Bash"
  echo "[2] Fish"
  echo "[3] Zsh"
  echo "If unsure, select Bash."
  printf "Choose an option (1/2/3) : " && read -r shell_choice
  if [ "$shell_choice" -lt 1 ] || [ "$shell_choice" -gt 3 ]; then
    printf "\n[ %s is an invalid Choice..\!\! ]\n\n" "$shell_choice"
  else
    break
  fi
done

# Executing switch statement based on shell choice
case $shell_choice in
    1)  # Apply bash customisations
        if command -v apt-get > /dev/null; then
          sudo apt-get -y install bash-completion
        elif command -v pacman > /dev/null; then
          sudo pacman -S --noconfirm bash-completion
        fi
        while ! chsh -s "$(command -v bash)"; do :; done;;
    2)  # Apply fish customisations
        if command -v apt-get > /dev/null; then
          sudo apt-get -y install fish python-is-python3
        elif command -v pacman > /dev/null; then
          sudo pacman -S --noconfirm fish
        fi
        while ! chsh -s "$(command -v fish)"; do :; done;;
    3)  # Apply zsh customisations
        if command -v apt-get > /dev/null; then
          sudo apt-get -y install zsh zsh-autosuggestions zsh-syntax-highlighting
        elif command -v pacman > /dev/null; then
          sudo pacman -S --noconfirm zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search
        fi
        printf "### SET XDG DIR FOR ZSH ###\nZDOTDIR=~/.config/zsh\n" | sudo tee -a /etc/zsh/zshenv > /dev/null # set dotfile directory for zsh
        while ! chsh -s "$(command -v zsh)"; do :; done;;
esac

# My custom scripts
./install-command-not-found.sh  # Command-not-found handler
./install-lsd.sh                # LSDeluxe - the fancy ls command
./install-neovim.sh             # Best text editor in the world ;-)
./install-terminal-apps.sh      # Terminal apps that I use
./install-tldr.sh               # Man pages, but simpler to understand
./setup-sudoers.sh              # Apply custom tweaks to sudoers file
./setup-xdg-base-dirs.sh        # Setup XDG Base Directories

# Install starship prompt
curl -sS https://starship.rs/install.sh | sh

