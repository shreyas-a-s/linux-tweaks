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

# Installation
sudo apt-get update && sudo apt-get -y install curl autojump bat neofetch trash-cli wget tldr fzf command-not-found git micro btop fonts-font-awesome fonts-noto-color-emoji

# Install lsd
./lsd.sh

# Shell choice
sudo apt-get -y install bash-completion # install bash customisations
sudo apt-get -y install fish python-is-python3 # install fish customisations
sudo apt-get -y install zsh zsh-autosuggestions zsh-syntax-highlighting # install zsh customisations
sudo sed -i '$ a\\n###\ SET\ XDG\ DIR\ FOR\ ZSH\ ###\nZDOTDIR=~/.config/zsh\n' /etc/zsh/zshenv # set dotfile directory for zsh
while true; do
echo "Which shell you prefer?"
echo "[1] Bash"
echo "[2] Fish"
echo "[3] Zsh"
echo "If unsure, select Bash."
echo "Choose an option (1/2/3) : " && read -r shell_choice
{ [ "$shell_choice" -lt 1 ] || [ "$shell_choice" -gt 3 ] } && printf "\n[ $shell_choice is an invalid Choice..\!\! ]\n\n" || break
done
case $shell_choice in
    1)
        while ! chsh -s "$(which bash)"; do :; done;;
    2)
        while ! chsh -s "$(which fish)"; do :; done;;
    3)
        while ! chsh -s "$(which zsh)"; do :; done;;
esac

# Setup Starship
curl -sS https://starship.rs/install.sh | sh

# Setup Directories
setupXDGUserDirs ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public
rm -d ~/desktop ~/music ~/templates ~/public

# Shell color scripts
(cd ~ && git clone https://github.com/shreyas-a-s/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Install neovim
./neovim.sh

# Update database of command-not-found
sudo update-command-not-found
sudo apt update

# Set default text editor
if which nvim > /dev/null; then
  sudo update-alternatives --set editor "$(which nvim)"
elif which micro > /dev/null; then
  sudo update-alternatives --set editor "$(which micro)"
else
  sudo update-alternatives --set editor "$(which nano)"
fi

# Update tldr database
tldr -u

