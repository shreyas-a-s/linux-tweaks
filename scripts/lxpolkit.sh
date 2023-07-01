#!/bin/bash

echo ""; echo "Checking whether to install lxpolkit or not..."
if [ "$distroname" == "Antix" ]; then
	if test -f ~/.config/i3/config; then
	    sed -i "/lxpolkit/ c\\" ~/.config/i3/config
	fi
	if test -f ~/.config/qtile/autostart.sh; then
		sed -i "/lxpolkit/ c\\" ~/.config/qtile/autostart.sh
	fi
	if test -f ~/.config/awesome/rc.lua; then
		sed -i "/lxpolkit/ c\\" ~/.config/awesome/rc.lua
	fi
	echo "Not installing lxpolkit coz it won't work properly in antix..."
else
	sudo apt install lxpolkit -y
fi
