#!/bin/bash

# Function to customise bash shell
function customiseBash {
	sudo apt install bash-completion -y
	cp dotfiles/bashextra ~/.config/.bashextra # my bash tweaks
	echo "source /home/""$username""/.config/.bashextra" | tee -a ~/.bashrc > /dev/null
	echo "source /home/""$username""/.config/.bashextra" | sudo tee -a /root/.bashrc > /dev/null
	curl -sS https://starship.rs/install.sh | sh # installing starship
	cp dotfiles/starship.toml ~/.config/ # startship configuration
	sudo cp dotfiles/fetch-master-6000 /usr/local/bin/fetch-master-6000 # Fetch command
    (sudo apt update && sudo apt install git make -y && cd .. && git clone https://gitlab.com/dwt1/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)
	echo -e '#!/usr/bin/bash\nfetch-master-6000 --random --color random --length=10 --margin=4' | sudo tee /opt/shell-color-scripts/colorscripts/fetch-master-6000-exec > /dev/null
    sudo chmod +x /opt/shell-color-scripts/colorscripts/fetch-master-6000-exec
}

# Function to customise fish shell
function customiseFish {
	sudo apt install fish python-is-python3 -y
	mkdir -p ~/.config/fish
	cp dotfiles/config.fish ~/.config/fish/
	chsh -s /usr/bin/fish # setting user shell to fish
	sudo chsh -s /usr/bin/fish # setting root shell to fish
}

# Installation
function shellChoice {
	read -r -p "Which shell you prefer? (bash/fish) : " shell_choice
	case "$shell_choice" in 
		"bash" ) customiseBash;;
		"fish" ) customiseFish;;
		* ) echo "Invalid Choice! Keep in mind this is CASE-SENSITIVE and type either bash or fish."; shellChoice;;
	esac
}
shellChoice
