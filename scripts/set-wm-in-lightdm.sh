#!/bin/bash

flag=true
echo ""
while [ $flag == true ] ; do
	echo "Which window manager you want to set as default in lightdm?"; echo -n "[1]i3 [2]awesome [3]qtile [4]xmonad [5]openbox [6]none : "; read -r fw
	if [ "$fw" == '1' ]; then
		
		flag=false
	elif [ "$fw" == '2' ]; then
		
		flag=false
	elif [ "$fw" == '3' ]; then
		
		flag=false
	elif [ "$fw" == '4' ]; then
		
		flag=false
	elif [ "$fw" == '5' ]; then
		
		flag=false
	elif [ "$fw" == '6' ]; then
		
		flag=false
	else
		echo "You have chosen invalid option. Choose either 1 or 2."
		echo ""
	fi
done
