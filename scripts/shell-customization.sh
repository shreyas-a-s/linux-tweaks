#!/bin/sh

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

  cp user-dirs.dirs ~/.config/
  xdg-user-dirs-update

}

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

# Installation
sudo apt-get update && sudo apt-get -y install curl autojump bat neofetch trash-cli wget tldr fzf command-not-found git micro btop make gh fonts-noto-color-emoji vifm ncdu

# Install lsd
./lsd.sh

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

# Setup Starship
curl -sS https://starship.rs/install.sh | sh

# Setup Directories
setupXDGUserDirs ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public
rm -d ~/desktop ~/music ~/templates ~/public

# Shell color scripts
(cd ../.. && git clone https://github.com/shreyas-a-s/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Disable creation of ~/.sudo_as_admin_successful
echo 'Defaults    !admin_flag' | sudo tee -a /etc/sudoers > /dev/null

# Install neovim
./neovim.sh

# Update database of command-not-found
sudo update-command-not-found
sudo apt update

# Update tldr database
tldr -u

