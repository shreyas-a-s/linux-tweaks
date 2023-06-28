# Debian Customisation
These are the customisations for debian that I use regardless of the Window Manager of choice.

## Screenshots
Check out **customised install screenshots** of my [i3](https://github.com/shreyasastech/debian-i3) & [qtile](https://github.com/shreyasastech/debian-qtile) configs.

## Features

- A single installation script for debian customisations
- Ability to choose bash or [fish](https://github.com/fish-shell/fish-shell) as the interactive shell in terminal.
- Both of them are customised out-of-the-box (bash using [starship](https://github.com/starship/starship) and fish using config file).
- Custom aliases on both shells.
- ls colors are tweaked using this [config](https://github.com/trapd00r/LS_COLORS/blob/master/lscolors.csh).
- Custom function in fish to extract all types of archive files
- Reduced the swappiness value so that RAM usage gets better.
- SSD optimisations (optional).
- GRUB Timeout set to 0 & Resolution set to 1366x768 (my monitor resolution).

## Programs that this script installs (only the major ones)

- [AM: Application Manager](https://github.com/ivan-hc/AM-Application-Manager) (AppImage Manager) - used for installing & updating Joplin
- [Autojump](https://github.com/wting/autojump) (A cd command that learns)
- [Bat](https://github.com/sharkdp/bat) (The improved cat command)
- [Fzf](https://github.com/junegunn/fzf) (Command-line file search tool)
- [Galculator](https://github.com/galculator/galculator) (Calculator)
- [Gparted](https://gitlab.gnome.org/GNOME/gparted) (The best disks & partition manager ever)
- [Joplin](https://github.com/laurent22/joplin) (Note taking app with sync capabilities & ed-to-end encryption)
- [KeePassXC](https://github.com/keepassxreboot/keepassxc)
- [LibreWolf](https://gitlab.com/librewolf-community/browser) (a Firefox fork browser)
- [lsd](https://github.com/lsd-rs/lsd) (the better ls command)
- [Micro](https://github.com/zyedidia/micro/) & [Lite-XL](https://github.com/lite-xl/lite-xl) (Text Editors)
- [Pcmanfm](https://github.com/lxde/pcmanfm) (File Manager)
- [TLDR](https://github.com/tldr-pages/tldr) (Simplified man pages)
- [Trash-cli](https://github.com/andreafrancia/trash-cli) (Command-line Trashcan)
- [Shellcheck](https://github.com/koalaman/shellcheck) (Analyse your shell scripts)
- [Vlc](https://github.com/videolan/vlc) (Video/Audio Player)

## Installation

Execute install.sh as **normal user** from a terminal:

```bash
 git clone https://github.com/shreyasastech/debian-customisation.git
 cd debian-customisation/
 .install.sh
```

For those who would like a single-line command:
```bash
 git clone https://github.com/shreyasastech/debian-customisation.git && cd debian-customisation/ && ./install.sh
```
