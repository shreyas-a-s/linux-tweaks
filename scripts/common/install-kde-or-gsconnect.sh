#!/bin/sh

if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
  busctl --user call org.gnome.Shell.Extensions /org/gnome/Shell/Extensions org.gnome.Shell.Extensions InstallRemoteExtension s gsconnect@andyholmes.github.io
else
  if command -v apt-get > /dev/null; then
    sudo apt-get install -y kdeconnect
  fi
fi

