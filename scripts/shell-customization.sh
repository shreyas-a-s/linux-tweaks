#!/bin/bash

# Variables
debianversion=$(awk -F '.' '{print $1}' < /etc/debian_version)

#
function setupXDGUserDirs {
	rm -r ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public
	mkdir ~/.config ~/desktop ~/documents ~/downloads ~/music ~/pictures ~/templates ~/videos ~/public
	cp ../dotfiles/user-dirs.dirs ~/.config/
	xdg-user-dirs-update
}
# Function to customise bash shell
function customiseBash {
    sudo apt-get -y install bash-completion git make command-not-found

	# XDG directory for bash files
	mkdir -p ~/.config/bash
    cp ../dotfiles/bash-extra ~/.config/bash/extra
	mv ~/.bashrc ~/.config/bash/rc
	mv ~/.bash_history ~/.config/bash/history
	echo -e "\n# Bash extra customisations\n. ~/.config/bash/extra" >> ~/.config/bash/rc
	echo -e "\nif [ -f ~/.config/bash/rc ]; then\n\t. ~/.config/bash/rc\nfi" | sudo tee -a /etc/bash.bashrc > /dev/null

	# Neofetch for root shell
	sudo sed -i '$ a\\n\#Neofetch\nif test -f "/usr/bin/neofetch"; then\n  neofetch\nfi' /root/.bashrc

	# Initialise autojump
	. /usr/share/autojump/autojump.sh

	# Move .bash_logout from home folder to /etc
	if [ -f ~/.bash_logout ]; then
		sudo mv ~/.bash_logout /etc/bash.bash_logout
	fi

	# Update database of command-not-found
	sudo update-command-not-found
	sudo apt update
}

# Function to customise fish shell
function customiseFish {
    sudo apt-get -y install fish python-is-python3
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/lscolors
	cp dotfiles/lscolors.csh ~/.config/lscolors/ # Adding some spash of colors to the good old ls command
	cp dotfiles/config.fish ~/.config/fish/
	chsh -s /usr/bin/fish # setting user shell to fish
}

# Shell choice
function shellChoice {
	read -r -p "Which shell you prefer? (bash/fish) : " shell_choice
	if [ "$shell_choice" != 'bash' ] && [ "$shell_choice" != 'fish' ]; then
		echo -e "Invalid Choice! Keep in mind this is CASE-SENSITIVE.\n"
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
sudo apt-get update && sudo apt-get -y install autojump bat neofetch trash-cli wget tldr fzf
lsdInstall
if [ "$shell_choice" = 'bash' ]; then
	customiseBash
elif [ "$shell_choice" = 'fish' ]; then
	customiseFish
fi
setupXDGUserDirs

# Shell color scripts
(cd ~ && git clone https://github.com/shreyas-a-s/shell-color-scripts.git && cd shell-color-scripts/ && sudo make install)

# Disable creation of .sudo_as_admin_successful
if [ -f ~/.sudo_as_admin_successful ]; then
	rm ~/.sudo_as_admin_successful
fi
echo 'Defaults    !admin_flag' | sudo tee -a /etc/sudoers > /dev/null

# Add password feedback (asterisks) for sudo
echo 'Defaults    pwfeedback' | sudo tee -a /etc/sudoers > /dev/null

# Set default text editor
if [ -f /usr/bin/micro ]; then
	sudo update-alternatives --set editor /usr/bin/micro
else
	sudo update-alternatives --set editor /usr/bin/nano
fi