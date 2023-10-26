#!/bin/bash

# Variables
debianversion=$(awk -F '.' '{print $1}' < /etc/debian_version)

#
function setupXDGUserDirs {

	rm -rf ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public
	mkdir -p ~/.config ~/desktop ~/documents ~/downloads ~/music ~/pictures ~/templates ~/videos ~/public
	cp ../dotfiles/user-dirs.dirs ~/.config/
	xdg-user-dirs-update

}
# Function to customise bash shell
function customiseBash {

    sudo apt-get -y install bash-completion make gawk

	# Create necessary directories
	mkdir -p ~/.config/lscolors

	# Neofetch for root shell
	sudo sed -i '$ a\\n\#Neofetch\nif test -f "/usr/bin/neofetch"; then\n  neofetch\nfi' /root/.bashrc

	# Initialise autojump
	. /usr/share/autojump/autojump.sh

	# Copy necessary files
	cp ../dotfiles/bash_aliases ~/.bash_aliases
	cp ../dotfiles/bash_extra ~/.bash_extra
	cp ../dotfiles/bash_functions ~/.bash_functions
	cp ../dotfiles/lscolors.sh ~/.config/lscolors/

	# Source extra files in .bashrc
	echo -e "\n\n# Bash Extra\n. ~/.bash_extra" >> ~/.bashrc
	echo -e "\n\n# Bash Functions\n. ~/.bash_functions" >> ~/.bashrc
	
	# Bash Line Editor by @akinomyoga on github
	git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
	make -C ble.sh install PREFIX=~/.local
	echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bash_extra

}

# Function to customise fish shell
function customiseFish {

    sudo apt-get -y install fish python-is-python3

	# Create necessary directories
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/lscolors

	# Copy necessary files
	cp ../dotfiles/lscolors.csh ~/.config/lscolors/ # Adding some spash of colors to the good old ls command
	cp ../dotfiles/config.fish ~/.config/fish/

}

# Shell choice
function shellChoice {

	echo "Which shell you prefer to customise?"
	echo "[1] Bash only"
	echo "[2] Fish only"
	echo "[3] Both but set Bash as Interactive Shell"
	echo "[4] Both but set Fish as Interactive Shell"
	echo "[5] None"
	read -r -p "Choose an option (1/2/3/4/5) : " shell_choice
	if ! [[ "$shell_choice" =~ ^[1-5]$ ]]; then
		echo -e "Invalid Choice..!!!\n"
		shellChoice
	fi

}

# lsd, the nexy-gen ls command
function lsdInstall {

	if [ "$debianversion" -lt 12 ]; then
		wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb
		sudo dpkg -i lsd_0.23.1_amd64.deb
		rm lsd_0.23.1_amd64.deb
	else
		sudo apt-get -y install lsd
	fi

}

# Check if variable is set
if [[ -z ${shell_choice} ]]; then
	shellChoice
fi

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Installation
sudo apt-get update && sudo apt-get -y install autojump bat neofetch trash-cli wget tldr fzf command-not-found git micro btop
lsdInstall
case $shell_choice in
    1)
        customiseBash && chsh -s /usr/bin/bash;;
    2)
        customiseFish && chsh -s /usr/bin/fish;;
    3)
        customiseFish; customiseBash && while ! chsh -s /usr/bin/bash; do :; done;;
    4)
        customiseBash; customiseFish && while ! chsh -s /usr/bin/fish; do :; done;;
esac
setupXDGUserDirs

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

# Update database of command-not-found
sudo update-command-not-found
sudo apt update