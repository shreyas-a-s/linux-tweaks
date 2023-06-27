#!/bin/bash

flag=true
while [ $flag == true ] ; do
	echo ""; echo  "Is debian installed to an SSD?"; echo -n "[y]yes [n]no [default]yes : "; read -r ssd_check
	if [ "$ssd_check" = "" ] || [ "$ssd_check" == 'y' ]; then
		echo "Adding noatime flags to fstab:" && sudo sed -i "s/errors=remount-ro/noatime,nodiratime,discard,errors=remount-ro/" /etc/fstab && flag=false
	elif [ "$ssd_check" == 'n' ]; then
		flag=false
	else
		echo "You have chosen invalid option. Choose either y or n."; echo ""
	fi
done
