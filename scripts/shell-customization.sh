#!/bin/sh

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
  { [ "$shell_choice" -lt 1 ] || [ "$shell_choice" -gt 3 ]; } && printf "\n[ $shell_choice is an invalid Choice..\!\! ]\n\n" || break
done

# Executing switch statement based on shell choice
case $shell_choice in
    1)
        sudo apt-get -y install bash-completion                                  # Apply bash customisations
        while ! chsh -s "$(command -v bash)"; do :; done;;
    2)
        sudo apt-get -y install fish python-is-python3                           # Apply fish customisations
        while ! chsh -s "$(command -v fish)"; do :; done;;
    3)
        sudo apt-get -y install zsh zsh-autosuggestions zsh-syntax-highlighting  # Apply zsh customisations
        sudo sed -i '$ a\\n###\ SET\ XDG\ DIR\ FOR\ ZSH\ ###\nZDOTDIR=~/.config/zsh\n' /etc/zsh/zshenv # set dotfile directory for zsh
        while ! chsh -s "$(command -v zsh)"; do :; done;;
esac

# My custom scripts
./install-command-not-found.sh  # Command-not-found handler
./install-lsd.sh                # LSDeluxe - the fancy ls command
./install-neovim.sh             # Best text editor in the world ;)
./install-terminal-apps.sh      # Terminal apps that I use
./install-tldr.sh               # Man pages, but simpler to understand
./setup-xdg-base-dirs.sh        # Setup XDG Base Directories

# Custom tweaks
curl -sS https://starship.rs/install.sh | sh                           # Install starship prompt
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null   # Add password feedback (asterisks) for sudo
echo 'Defaults    !admin_flag' | sudo tee -a /etc/sudoers > /dev/null  # Disable creation of ~/.sudo_as_admin_successful

