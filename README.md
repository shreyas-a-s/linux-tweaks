# Debian Customisation
These are the customisations for debian that I use regardless of the Window Manager of choice.

## Features

- A single installation script for debian customisations
- Ability to choose bash or fish as the interactive shell in terminal.
- Both of them are customised out-of-the-box (bash using starship and fish using config file).
- Custom aliases on both shells.
- ls colors are c
- Reduced the swappiness value so that RAM usage gets better.
- SSD optimisations (optional).
- GRUB Timeout set to 0 & Resolution set to 1366x768 (my monitor resolution).

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
