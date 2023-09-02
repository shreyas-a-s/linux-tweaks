#!/bin/bash
sudo apt install flatpak -y
if [ "$DESKTOP_SESSION" == "gnome" ]; then
	sudo apt install gnome-software-plugin-flatpak -y
fi
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.discordapp.Discord com.github.tchx84.Flatseal com.obsproject.Studio com.slack.Slack com.spotify.Client de.haeckerfelix.Fragments net.cozic.joplin_desktop org.onlyoffice.desktopeditors -y