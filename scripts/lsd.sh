#!/bin/bash

echo ""; echo "Installing lsd, the next gen 'ls' command..."
if [ "$debianversion" -lt 12 ]; then
	wget -q -nv -O - https://api.github.com/repos/lsd-rs/lsd/releases/latest   | awk -F': ' '/browser_download_url/ && /\_amd64.deb/ \
	                             {gsub(/"/, "", $(NF)); system("wget -qi -L " $(NF))}' && rm lsd-musl* && mv *.deb lsd.deb && sudo dpkg -i lsd.deb && rm lsd.deb
else
	sudo apt install lsd -y
fi
