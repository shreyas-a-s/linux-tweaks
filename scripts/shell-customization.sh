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

# Installation
flag=true
echo ""; echo "Some shell customisations are available for the shell..."
while [ $flag == true ] ; do
	read -r -p "...Do you use bash or fish? [1]bash [2]fish : " choice
	if [ "$choice" == '1' ]; then
		customiseBash
		flag=false
	elif [ "$choice" == '2' ]; then
		customiseFish
		flag=false
	else
		echo "You have chosen invalid option. Choose either 1 or 2."
		echo ""
	fi
done

if [ "$DESKTOP_SESSION" == "gnome" ]; then
    sed -i "a\alias gedit='gnome-text-editor'" ~/.bash_aliases
fi