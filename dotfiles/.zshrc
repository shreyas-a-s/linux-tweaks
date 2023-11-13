### SETUP THE PROMPT ###
setopt histignorealldups sharehistory

### EXPORT ###
export TERM="xterm-256color" # getting proper colors
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
if [ -f /usr/bin/micro ]; then
  export EDITOR="micro"
  export VISUAL="micro"
fi

### HISTORY SETTINGS ###
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.config/zsh/.zsh_history

### USE MODERN COMPLETION SYSTEM ###
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

### SET MANPAGER
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PATH ###
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "/var/lib/flatpak/exports/bin/" ] ;
  then PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi

if [ -d "/usr/games/" ] ;
  then PATH="/usr/games/:$PATH"
fi

### CHANGE TITLE OF TERMINALS ###
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### ALIASES ###

# Changing "ls" to "exa"
if [ -f "/usr/bin/exa" ]; then
  alias ls='exa -a --color=always --group-directories-first'  # all files and dirs
  alias ll='exa -al --color=always --group-directories-first' # my preferred listing
  alias lt='exa -aT --color=always --group-directories-first' # tree listing
else
  alias ls='ls --color=auto'
  alias la='ls -A --color=auto'
  alias ll='ls -alh --color=auto'
fi

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Add verbose output to cp, mv & mkdir
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Enable command-line trash
if [ -f "/usr/bin/trash" ]; then
  alias rm='trash'
fi

# Colorize cat command
if [ -f "/usr/bin/batcat" ]; then
  alias cat='batcat --style=plain'
fi

# Make aliases work even if preceded by sudo
alias sudo='sudo '

# Change apt command to nala
if [ -f "/usr/bin/nala" ]; then
  alias apt='nala'
fi

# Allows shellcheck to follow any file the script may source
alias shellcheck='shellcheck -x'

# Force start btop even if no UTF-8 locale was detected
alias btop='btop --utf-force'

### RANDOM COLOR SCRIPT ###
# Get this script from my Github: github.com/shreyas-a-s/shell-color-scripts
if [ -f /usr/local/bin/colorscript ]; then
  colorscript random
fi

### AUTOJUMP
if [ -f "/usr/share/autojump/autojump.zsh" ]; then
  . /usr/share/autojump/autojump.zsh
fi

# Set colors for ls command
if [ -f "$HOME/.config/lscolors/lscolors.sh" ]; then
  source ~/.config/lscolors/lscolors.sh
fi

### FUNCTIONS ###

# Create and go to the directory
function mkdircd {
	mkdir -p "$1"
	cd "$1"
}

# My Ping ;)
function ping {
	if [ -z "$1" ]; then
		command ping -c 1 example.org
	else
		command ping "$@"
	fi
}

# Function to use ix.io (the command-line pastebin)
function ix {
  curl -F "f:1=@$1" ix.io
}

# Function to select correct neovim
function vim {
  if whereis nvim | awk '{print $2}' | grep nvim > /dev/null; then
    command nvim "$@"
  elif flatpak list | grep nvim > /dev/null; then
    flatpak run io.neovim.nvim "$@"
  else
    command vim "$@"
  fi
}

# Function to extract common file formats
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

### AUTOSUGGESTIONS ###
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

### SYNTAX-HIGHLIGHTING ###
if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

### COMMAND-NOT-FOUND ###
if [ -f /etc/zsh_command_not_found ]; then
  . /etc/zsh_command_not_found
fi

### SETTING THE STARSHIP PROMPT ###
if [ -f /usr/local/bin/starship ]; then
  eval "$(starship init zsh)"
fi
