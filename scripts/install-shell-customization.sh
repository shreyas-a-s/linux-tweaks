#!/bin/bash

# Function to customise bash shell
function customiseBash {
	sudo apt install bash-completion -y
	echo "source /home/""$username""/.config/.bashextra" | tee -a ~/.bashrc > /dev/null
	curl -sS https://starship.rs/install.sh | sh # installing starship
}

# Function to customise fish shell
function customiseFish {
	sudo apt install fish python-is-python3 -y
	chsh -s /usr/bin/fish # setting user shell to fish
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
