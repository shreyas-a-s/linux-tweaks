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

  cp ../dotfiles/user-dirs.dirs ~/.config/
  xdg-user-dirs-update

}

# Function to customise bash shell
customiseBash() {

  sudo apt-get -y install bash-completion

  # Create necessary directories
  mkdir -p ~/.config/bash
  mkdir -p ~/.config/lscolors

  # Copy necessary files
  mv ~/.bash_history ~/.config/bash/
  cp ../dotfiles/lscolors.sh ~/.config/lscolors/

}

# Function to customise fish shell
customiseFish() {

  sudo apt-get -y install fish python-is-python3

  # Create necessary directories
  mkdir -p ~/.config/fish
  mkdir -p ~/.config/lscolors

  # Copy necessary files
  cp ../dotfiles/lscolors.csh ~/.config/lscolors/ # Adding some spash of colors to the good old ls command

}

# Function to customise zsh shell
customiseZsh() {

  sudo apt-get -y install zsh zsh-autosuggestions zsh-syntax-highlighting

  # Create necessary directories
  mkdir -p ~/.config/zsh
  mkdir -p ~/.config/lscolors

  # Copy necessary files
  cp ../dotfiles/lscolors.sh ~/.config/lscolors/

  # Set dotfile directory for zsh
  sudo sed -i '$ a\\n###\ SET\ XDG\ DIR\ FOR\ ZSH\ ###\nZDOTDIR=~/.config/zsh\n' /etc/zsh/zshenv
  
}

# Shell choice
shellChoice() {

  echo "Which shell you prefer?"
  echo "[1] Bash"
  echo "[2] Fish"
  echo "[3] Zsh"
  echo "If unsure, select Bash."
  echo "Choose an option (1/2/3) : " && read -r shell_choice
  [ "$shell_choice" -lt 1 ] || [ "$shell_choice" -gt 3 ] && printf "\n[ $shell_choice is an invalid Choice..\!\! ]\n\n" && shellChoice

}

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Installation
shellChoice
sudo apt-get update && sudo apt-get -y install curl autojump bat neofetch trash-cli wget tldr fzf command-not-found git micro btop fonts-font-awesome fonts-noto-color-emoji

# Install utilities for extract function
sudo apt-get install -y tar xz-utils bzip2 unrar-free gzip unzip p7zip-full cabextract cpio unace

# Install lsd
if apt-cache show lsd > /dev/null; then
  sudo apt-get install -y lsd
else
  wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
  sudo dpkg -i lsd_0.23.1_amd64.deb
  rm lsd_0.23.1_amd64.deb
fi

# Shell choice
customiseBash
customiseFish
customiseZsh
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
cp ../dotfiles/starship.toml ~/.config/

# Setup Directories
setupXDGUserDirs ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public
rm -d ~/desktop ~/music ~/templates ~/public
mkdir -p ~/downloads/kdeconnect

# Shell color scripts
(cd ~ && git clone https://github.com/shreyas-a-s/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Copy config file for micro
mkdir -p ~/.config/micro/
cp ../dotfiles/settings.json ~/.config/micro/

# Update database of command-not-found
sudo update-command-not-found
sudo apt update

# Install neovim
if [ "$(apt-cache show neovim | grep Version | awk -F '.' '{print $2}')" -ge 9 ]; then
  sudo apt-get install -y neovim
else
  ./neovim-appimage-updater.sh
  sudo cp neovim-appimage-updater.sh /usr/local/bin/neovim-appimage-updater
fi

# Set default text editor
if which nvim > /dev/null; then
  sudo update-alternatives --set editor $(which nvim)
elif which micro > /dev/null; then
  sudo update-alternatives --set editor $(which micro)
else
  sudo update-alternatives --set editor $(which nano)
fi

# Update tldr database
tldr -u

# Declutter HOME directory
echo "Do you want to declutter your home folder by removing some files? (yes/no)" && read -r declutter_choice
case $declutter_choice in
  y|yes|Yes|YES)
    rm ~/.bash_logout
    rm ~/.profile
    rm ~/.sudo_as_admin_successful
    rm ~/.wget-hsts
esac
