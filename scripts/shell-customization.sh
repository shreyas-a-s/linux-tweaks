#!/bin/bash

# Function to customise bash shell
function customiseBash {
    sudo apt-get -y install bash-completion git make
	if test -f "./dotfiles/bash_aliases"; then
    	cp dotfiles/bash_aliases ~/.bash_aliases
	else
    	cp ../dotfiles/bash_aliases ~/.bash_aliases
	fi
    (cd .. && git clone https://github.com/shreyas-a-s/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)
	sudo sed -i '$ a\\n\#Neofetch\nif test -f "/usr/bin/neofetch"; then\n  neofetch\nfi' /root/.bashrc
	. /usr/share/autojump/autojump.sh
}

# Function to customise fish shell
function customiseFish {
    sudo apt-get -y install fish python-is-python3
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/lscolors
	cp dotfiles/lscolors.csh ~/.config/lscolors/ # Adding some spash of colors to the good old ls command
	cp dotfiles/config.fish ~/.config/fish/
	chsh -s /usr/bin/fish # setting user shell to fish
	sudo chsh -s /usr/bin/fish # setting root shell to fish
}

# Shell choice
function shellChoice {
	read -r -p "Which shell you prefer? (bash/fish) : " shell_choice
	if [ "$shell_choice" != 'bash' ] && [ "$qemu_choice" != 'fish' ]; then
		echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
    	shellChoice
  	fi
}

# Check if variable is set
if [[ -z ${shell_choice} ]]; then
	shellChoice
fi

# Installation
sudo apt-get update && sudo apt-get -y install autojump bat neofetch
if [ $shell_choice = 'bash' ]; then
	customiseBash
elif [ $shell_choice = 'fish' ]; then
	customiseFish
fi
