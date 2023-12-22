# Linux Tweaks
These are the customisations for linux (currently debian-based and archlinux-based) that I use regardless of the Desktop Environment or Window Manager.

## Features

- A single installation script for all of the customisations
- Ability to choose bash, [fish](https://github.com/fish-shell/fish-shell) or [zsh](https://github.com/zsh-users/zsh) as the interactive shell in terminal.
- All of them are customised out-of-the-box (using their respective config files & [starship](https://github.com/starship/starship) prompt).
- Custom aliases on all shells.

## Programs that this script installs (only the major ones)

- [Bat](https://github.com/sharkdp/bat) (The improved cat command)
- [Fzf](https://github.com/junegunn/fzf) (Command-line file search tool)
- [Gparted](https://gitlab.gnome.org/GNOME/gparted) (The best disks & partition manager ever)
- [Joplin](https://github.com/laurent22/joplin) (Note taking app with sync capabilities & ed-to-end encryption)
- [KeePassXC](https://github.com/keepassxreboot/keepassxc)
- [lsd](https://github.com/lsd-rs/lsd) (the better ls command)
- [TLDR](https://github.com/tldr-pages/tldr) (Simplified man pages)
- [Trash-cli](https://github.com/andreafrancia/trash-cli) (Command-line Trashcan)
- [Shellcheck](https://github.com/koalaman/shellcheck) (Analyse your shell scripts)
- [Vlc](https://github.com/videolan/vlc) (Video/Audio Player)

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

