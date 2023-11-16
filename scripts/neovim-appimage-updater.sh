#!/bin/sh

printf "\nLooking for Neovim AppImage updates..."

if whereis nvim | awk '{print $2}' | grep -q nvim; then
  
  currentnvimversion=$(nvim -v | awk -F 'NVIM v' 'NR==1{print $2}')                                               
  latestnvimversion=$(curl -s https://github.com/neovim/neovim/releases/tag/stable | grep 'NVIM v' | awk -F 'NVIM v' 'NR==1{print $2}')
  
  currentminorversion=$(echo $currentnvimversion | awk -F . '{print $2}')
  latestminorversion=$(echo $latestnvimversion | awk -F . '{print $2}')
  
  currentpatchversion=$(echo $currentnvimversion | awk -F . '{print $3}')
  latestpatchversion=$(echo $latestnvimversion | awk -F . '{print $3}')
  
  if [ $currentminorversion -lt $latestminorversion ] || ([ $currentminorversion -eq $latestminorversion ] && [ $currentpatchversion -lt $latestpatchversion ]); then
    
    printf "\n\n Found a new version on Github. Installing it...\n"
    sleep 1

    wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod +x nvim.appimage
    sudo mv nvim.appimage /usr/local/bin/nvim

  else
    
    printf "\n\n"
    echo "Nothing to do. Neovim is up-to-date with version: $latestnvimversion"

  fi

else

  printf "/n/nNeovim is not installed. Installing now...\n"
  sleep 1

  wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  chmod +x nvim.appimage
  sudo mv nvim.appimage /usr/local/bin/nvim 

fi
