#!/bin/bash

flag=true
echo ""; echo "Some shell customisations are available for the shell..."
while [ $flag == true ] ; do
	echo "...Do you use bash or fish?"; echo -n "[1]bash [2]fish : "; read -r fw
	if [ "$fw" == '1' ]; then
		sudo apt install bash-completion -y
		cp dotfiles/bash_aliases ~/.bash_aliases # my bash tweaks

		flag=false
	elif [ "$fw" == '2' ]; then
		sudo apt install fish python-is-python3 -y
		mkdir -p ~/.config/fish
		mkdir -p ~/.config/lscolors
		cp dotfiles/lscolors.csh ~/.config/lscolors/ # Adding some spash of colors to the good old ls command
		cp dotfiles/config.fish ~/.config/fish/
		chsh -s /usr/bin/fish # setting user shell to fish
		sudo chsh -s /usr/bin/fish # setting root shell to fish
		flag=false
	else
		echo "You have chosen invalid option. Choose either 1 or 2."
		echo ""
	fi
done

if [ $DESKTOP_SESSION == "gnome" ]; then
    sed -i "a\alias gedit='gnome-text-editor'" ~/.bash_aliases
fi