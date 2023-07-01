#!/bin/bash

if test -f ~/.config/i3/config; then
	sed -i "/--set-zoom-fill/ c\exec \t\t--no-startup-id nitrogen --restore &" ~/.config/i3/config
	sed -i "/wall/ c\\" ~/.config/i3/config
fi

if test -f ~/.config/qtile/config.py; then
	sed -i "/wall/ c\\" ~/.config/qtile/config.py
fi

if test -f ~/.config/qtile/autostart.sh; then
	sed -i "/--set-zoom-fill/ c\nitrogen --restore &" ~/.config/qtile/autostart.sh
fi

if test -f ~/.config/awesome/rc.lua; then
	sed -i "/--set-zoom-fill/ c\nitrogen --restore &" ~/.config/awesome/rc.lua
	sed -i "/wall/ c\\" ~/.config/awesome/rc.lua
fi

rm ~/wall-set.sh
