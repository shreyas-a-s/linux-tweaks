#!/bin/sh

# Install for debian-based distros
if command -v apt-get > /dev/null; then
  mkdir -p -m 700 ~/.gnupg
  gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
  chmod 644 /tmp/onlyoffice.gpg
  sudo chown root:root /tmp/onlyoffice.gpg
  sudo mv /tmp/onlyoffice.gpg /usr/share/keyrings/onlyoffice.gpg
  echo 'deb [signed-by=/usr/share/keyrings/onlyoffice.gpg] https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
  # To set third-party repositories to have least priority
  echo 'Package: *
  Pin: origin download.onlyoffice.com
  Pin-Priority: 100' | sudo tee /etc/apt/preferences.d/onlyoffice.pref > /dev/null
  sudo apt-get update
  sudo apt-get -y install onlyoffice-desktopeditors
fi

