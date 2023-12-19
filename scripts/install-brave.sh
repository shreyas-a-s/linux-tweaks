#!/bin/sh

if command -v apt-get > /dev/null; then # Install for debian-based distros
    # Add repository
    sudo apt-get update
    sudo apt-get -y install curl
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    
    # To set third-party repositories to have least priority
    echo 'Package: *\
    \nPin: origin brave-browser-apt-release.s3.brave.com\
    \nPin-Priority: 100' | sudo tee /etc/apt/preferences.d/brave.pref > /dev/null
    
    # Install the app
    sudo apt-get update
    sudo apt-get -y install brave-browser
fi

