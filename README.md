# Linux Tweaks
These are the customisations for linux (currently Debian, Archlinux, NixOS & RHEL based linux distros) that I use regardless of the Desktop Environment or Window Manager.

## Screenshots
![desktop](https://github.com/shreyas-a-s/linux-tweaks/assets/137637016/39040215-2486-45f4-8009-1a6a6bdf833b)

## Features

- A single installation script for all of the customisations
- Ability to choose bash, [fish](https://github.com/fish-shell/fish-shell) or [zsh](https://github.com/zsh-users/zsh) as the interactive shell in terminal.
- All of them are customised out-of-the-box (using their respective config files & [starship](https://github.com/starship/starship) prompt).
- Custom aliases on all shells.

## Programs that this script installs (only the major ones)

### GUI Programs
- [Gparted](https://gitlab.gnome.org/GNOME/gparted) (The best disks & partition manager ever)
- [Joplin](https://github.com/laurent22/joplin) (Note taking app with sync capabilities & ed-to-end encryption)
- [KeePassXC](https://github.com/keepassxreboot/keepassxc) (Offline password manager)
- [OBS Studio](https://github.com/obsproject/obs-studio) (Industry-standard software for screen recording & streaming)
- [Vlc](https://github.com/videolan/vlc) (Video/Audio Player)

### Terminal Programs
- [Bat](https://github.com/sharkdp/bat) (The improved cat command)
- [Fzf](https://github.com/junegunn/fzf) (Command-line file search tool)
- [LSDeluxe](https://github.com/lsd-rs/lsd) (The better ls command)
- [NCurses Disk Usage](https://dev.yorhel.nl/ncdu) (Command-line disk usage analyzer)
- [Neovim](https://github.com/neovim/neovim) (Extensible command-line text editor)
- [TLDR](https://github.com/tldr-pages/tldr) (Simplified man pages)
- [Trash-cli](https://github.com/andreafrancia/trash-cli) (Command-line Trashcan)
- [Shellcheck](https://github.com/koalaman/shellcheck) (Analyse your shell scripts)
- [Zoxide](https://github.com/ajeetdsouza/zoxide) (Smarter cd command)

### GNOME-Suite Programs
- [Fragments](https://gitlab.gnome.org/World/Fragments) (GNOME-suite torrent client)
- [GSConnect](https://github.com/GSConnect/gnome-shell-extension-gsconnect) (KDE Connect implementation for GNOME)
- [Secrets](https://gitlab.gnome.org/World/secrets) (GNOME-suite password manager that is Keepass-based)

## Installation

Execute install.sh as **normal user** from a terminal:

```bash
 git clone https://github.com/shreyas-a-s/linux-tweaks.git
 cd linux-tweaks/
 ./install.sh
```

For those who would like a single-line command:
```bash
 git clone https://github.com/shreyas-a-s/linux-tweaks.git && cd linux-tweaks/ && ./install.sh
```

