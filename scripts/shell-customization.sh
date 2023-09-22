#!/bin/bash

# Function to customise bash shell
function customiseBash {
    sudo apt install bash-completion -y
    cp dotfiles/bash_aliases ~/.bash_aliases # my bash tweaks
	sudo cp dotfiles/fetch-master-6000 /usr/local/bin/fetch-master-6000 # Fetch command
    (sudo apt update && sudo apt install git make -y && cd .. && git clone https://gitlab.com/dwt1/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)
	echo -e '#!/usr/bin/bash\nfetch-master-6000 --random --color random --length=10 --margin=4' | sudo tee /opt/shell-color-scripts/colorscripts/fetch-master-6000-exec > /dev/null
    sudo chmod +x /opt/shell-color-scripts/colorscripts/fetch-master-6000-exec
}

# Function to customise fish shell
function customiseFish {
    sudo apt install fish python-is-python3 -y
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
if [[ -n ${shell_choice} ]]
	shellChoice
fi

# Installation
if [ $shell_choice = 'bash' ]; then
	customiseBash
else
	customiseFish
fi

# Alias gedit to gnome-text-editor
if [ "$DESKTOP_SESSION" == "gnome" ]; then
    sed -i "$ a alias gedit='gnome-text-editor'" ~/.bash_aliases
fi