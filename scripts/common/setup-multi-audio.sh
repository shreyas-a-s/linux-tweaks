#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - MULTI DEVICE AUDIO"
fi

### Installs programs to enable routing audio to multiple devices simultaneousily ###
if command -v apt-get > /dev/null; then # Install for debian-based distros
  sudo apt-get install -y pipewire-jack qjackctl
elif command -v pacman > /dev/null; then # Install for archlinux-based distros
  sudo pacman -S --noconfirm pipewire-jack qjackctl
elif command -v dnf > /dev/null; then # Install for RHEL-based distros
  sudo dnf install -y pipewire-jack-audio-connection-kit qjackctl
fi

### Usage ###
# Play audio/video, run command pw-jack qjackctl, then click the "Graph" button, and finally
# drag a connection between the source of your audio and your output devices' sinks.

### Source ###
# stackoverflow discussion @ https://stackoverflow.com/a/70287685

