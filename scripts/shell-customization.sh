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

  sudo apt-get -y install bash-completion make gawk git

  # Create necessary directories
  mkdir -p ~/.config/lscolors

  # Neofetch for root shell
  sudo sed -i '$ a\\n\#Neofetch\nif test -f "/usr/bin/neofetch"; then\n  neofetch\nfi' /root/.bashrc

  # Copy necessary files
  cp ../dotfiles/.bashrc ~/
  cp ../dotfiles/lscolors.sh ~/.config/lscolors/

  # Bash Line Editor by @akinomyoga on github
  (cd ../.. &&\
  git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git &&\
  make -C ble.sh install PREFIX=~/.local &&\
  printf '\n\n#Bash Line Editor by @akinomyoga on github\nsource ~/.local/share/blesh/ble.sh' >> ~/.bashrc)

}

# Function to customise fish shell
customiseFish() {

  sudo apt-get -y install fish python-is-python3

  # Create necessary directories
  mkdir -p ~/.config/fish
  mkdir -p ~/.config/lscolors

  # Copy necessary files
  cp ../dotfiles/lscolors.csh ~/.config/lscolors/ # Adding some spash of colors to the good old ls command
  cp ../dotfiles/config.fish ~/.config/fish/

}

# Function to customise zsh shell
customiseZsh() {

  sudo apt-get -y install zsh zsh-autosuggestions zsh-syntax-highlighting

  # Create necessary directories
  mkdir -p ~/.config/zsh
  mkdir -p ~/.config/lscolors

  # Copy necessary files
  cp ../dotfiles/.zshrc ~/.config/zsh/
  cp ../dotfiles/lscolors.sh ~/.config/lscolors/

  # Set dotfile directory for zsh
  sudo sed -i '$ a\\n###\ SET\ XDG\ DIR\ FOR\ ZSH\ ###\nZDOTDIR=~/.config/zsh\n' /etc/zsh/zshenv
  
}

# Shell choice
shellChoice() {

  echo "Which shell you prefer to customise?"
  echo "[1] Bash"
  echo "[2] Fish"
  echo "[3] Zsh"
  echo "[4] None"
  echo "Choose an option (1/2/3/4) : " && read -r shell_choice
  [ "$shell_choice" -lt 1 ] || [ "$shell_choice" -gt 4 ] && printf "Invalid Choice..!!!\n\n" && shellChoice

}

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Installation
shellChoice
sudo apt-get update && sudo apt-get -y install curl autojump bat neofetch trash-cli wget tldr fzf command-not-found git micro btop exa

case $shell_choice in
    1)
        customiseBash && while ! chsh -s "$(whereis bash | awk '{print $2}')"; do :; done;;
    2)
        customiseFish && while ! chsh -s "$(whereis fish | awk '{print $2}')"; do :; done;;
    3)
        customiseZsh && while ! chsh -s "$(whereis zsh | awk '{print $2}')"; do :; done;;
esac

# Setup Starship
curl -sS https://starship.rs/install.sh | sh
cp ../dotfiles/starship.toml ~/.config/

setupXDGUserDirs ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public
rm -r ~/desktop ~/music ~/templates ~/public
mkdir -p ~/downloads/kdeconnect

# Shell color scripts
(cd ~ && git clone https://github.com/shreyas-a-s/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Set default text editor
if [ -f /usr/bin/micro ]; then
  sudo update-alternatives --set editor /usr/bin/micro
else
  sudo update-alternatives --set editor /usr/bin/nano
fi

# Copy config file for micro
mkdir -p ~/.config/micro/
cp ../dotfiles/settings.json ~/.config/micro/

# Update database of command-not-found
sudo update-command-not-found
sudo apt update
