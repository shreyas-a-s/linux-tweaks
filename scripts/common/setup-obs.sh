#!/usr/bin/env bash

# Display title of script
if type _printtitle &> /dev/null; then
  _printtitle "SETTING UP - OBS STUDIO"
fi

mkdir -p ~/.config/obs-studio/basic/profiles/Untitled
mkdir -p ~/videos/obs
cp ../../components/basic.ini ~/.config/obs-studio/basic/profiles/Untitled/
sed -i "/FilePath/c FilePath=\/home\/$USER\/videos\/obs" ~/.config/obs-studio/basic/profiles/Untitled/basic.ini
