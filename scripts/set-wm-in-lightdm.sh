#!/bin/bash

# Some colors, just for aesthetics
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # no color

# Actual code
flag=false
echo ""
while [ $flag == false ] ; do
	flag=true
	echo "Which window manager you want to set as default in lightdm?"
	echo -ne "[${CYAN}1${NC}]i3 [${CYAN}2${NC}]awesome [${CYAN}3${NC}]qtile [${CYAN}4${NC}]xmonad [${CYAN}5${NC}]openbox [${CYAN}6${NC}]none : "
	read -r windowmanager
	case $windowmanager in

	  1)
	    wmname="i3"
	    ;;

	  2)
	    wmname="awesome"
	    ;;

	  3)
	    wmname="qtile"
	    ;;

	  4)
	    wmname="xmonad"
	    ;;

	  5)
	    wmname="openbox"
	    ;;

	  6)
	    ;;

	  *)
	    flag=false
	    echo ""
	    echo -e "[${RED}ERROR${NC}] That was an invalid option. Choose a number from 1-6."
	    ;;
	esac
done

if [ "$windowmanager" != '6' ]; then
    sudo sed -i "/your-fav-wm/ c\user-session=""$wmname""" /etc/lightdm/lightdm.conf
fi
