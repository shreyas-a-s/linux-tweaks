#!/bin/bash

flag=true
echo ""; echo "Some shell customisations are available for the shell..."
while [ $flag == true ] ; do
	read -r -p "...Do you use bash or fish? [1]bash [2]fish : " choice
	if [ "$choice" == '1' ]; then
		sudo apt install bash-completion -y
		cp dotfiles/bashextra ~/.config/.bashextra # my bash tweaks
		echo "source /home/""$username""/.config/.bashextra" | tee -a ~/.bashrc > /dev/null
		echo "source /home/""$username""/.config/.bashextra" | sudo tee -a /root/.bashrc > /dev/null
		curl -sS https://starship.rs/install.sh | sh # installing starship
		cp dotfiles/starship.toml ~/.config/ # startship configuration
		flag=false
	elif [ "$choice" == '2' ]; then
		sudo apt install fish python-is-python3 -y
		mkdir -p ~/.config/fish
		cp dotfiles/config.fish ~/.config/fish/
		chsh -s /usr/bin/fish # setting user shell to fish
		sudo chsh -s /usr/bin/fish # setting root shell to fish
		flag=false
	else
		echo "You have chosen invalid option. Choose either 1 or 2."
		echo ""
	fi
done
