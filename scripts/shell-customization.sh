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

# Executing shell choice
case $shell_choice in
    1)
        sudo apt-get -y install bash-completion # install bash customisations
        while ! chsh -s "$(command -v bash)"; do :; done;;
    2)
        sudo apt-get -y install fish python-is-python3 # install fish customisations
        while ! chsh -s "$(command -v fish)"; do :; done;;
    3)
        sudo apt-get -y install zsh zsh-autosuggestions zsh-syntax-highlighting # install zsh customisations
        sudo sed -i '$ a\\n###\ SET\ XDG\ DIR\ FOR\ ZSH\ ###\nZDOTDIR=~/.config/zsh\n' /etc/zsh/zshenv # set dotfile directory for zsh
        while ! chsh -s "$(command -v zsh)"; do :; done;;
esac

# My custom scripts
./install-terminal-apps.sh # Install terminal apps that I use
./install-lsd.sh # Install lsd
./install-command-not-found.sh # Install command-not-found handler
./neovim.sh # Install neovim
./install-tldr.sh # install and update tldr database
./setup-xdg-base-dirs.sh # Setup XDG Base Directories

# Setup Starship
curl -sS https://starship.rs/install.sh | sh

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Disable creation of ~/.sudo_as_admin_successful
echo 'Defaults    !admin_flag' | sudo tee -a /etc/sudoers > /dev/null

