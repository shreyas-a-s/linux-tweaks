### SET XDG USER DIRECTORES ###
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

### EXPORT ###
export TERM="xterm-256color"                                  # getting proper colors
export WGETRC=$XDG_CONFIG_HOME/wgetrc                         # to set xdg base directory for wget
export LESSHISTFILE=-                                         # prevent creation of ~/.lesshst file
if which nvim > /dev/null; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

### HISTORY SETTINGS ###
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history

# Set colors for ls command
if [ -f "$XDG_CONFIG_HOME/lscolors/lscolors.sh" ]; then
  . $XDG_CONFIG_HOME/lscolors/lscolors.sh
fi

### USE MODERN COMPLETION SYSTEM ###
autoload -Uz compinit
compinit
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'

### USE BEAM SHAPE CURSOR ###

# use beam shape cursor on startup.
echo -ne '\e[5 q'

# use beam shape cursor for each new prompt.
function _fix_cursor {
  echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

### SET MANPAGER
if which batcat > /dev/null; then
  export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
fi

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

### SETOPT ###
setopt histignorealldups # do not put duplicated command into history list
setopt histsavenodups # do not save duplicated command
setopt histfindnodups # when searching for history entries, do not display duplicates
setopt histignorespace # don't store command lines in history when the first character is a space 
setopt histreduceblanks # remove unnecessary blanks
setopt incappendhistory # append typed commands to histfile immediately 
setopt noautoremoveslash # don't remove slash for directories after auto tab completion
setopt globdots # show hidden files in tab completion
unsetopt listtypes # don't show trailing identifying marks for files while listing for completion

### ALIASES ###

# To select correct neovim
if which nvim > /dev/null; then
  alias vim='nvim'
elif flatpak list | grep nvim > /dev/null; then
  alias vim='flatpak run io.neovim.nvim'
fi

# To set XDG Base Directory for wget
[ -f $XDG_CONFIG_HOME/wgetrc ] || touch $XDG_CONFIG_HOME/wgetrc && alias wget='wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'

# Update all packages on system
alias allup='sudo apt update && sudo apt upgrade -y; flatpak update -y; which neovim-appimage-updater > /dev/null && neovim-appimage-updater'

# Tree command - Show all files including hidden ones
alias tree='tree -a'

# Better ls commands
if which lsd > /dev/null; then
  alias ls='lsd -A'
  function ll {
    if [ "$1" = "-g" ]; then
      shift
      lsd -Al --blocks permission,user,group,size,date,name --date +%d\ %b\ %H:%m --size short --group-directories-first "$@"
    else
      lsd -Al --blocks permission,user,size,date,name --date +%d\ %b\ %H:%m --size short --group-directories-first "$@"
    fi
  }
  alias lt='lsd --tree --group-directories-first'
else
  alias ls='ls -A --color=auto --group-directories-first'
  alias ll='ls -Alh --color=auto --group-directories-first'
  alias lt='tree --dirsfirst'
fi

# Colorize grep output (good for log files)
alias grep='grep -i --color=auto'
alias egrep='egrep -i --color=auto'
alias fgrep='fgrep -i --color=auto'

# Adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Add verbose output to cp, mv & mkdir
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Enable command-line trash
if which trash > /dev/null; then
  alias rm='trash'
fi

# Colorize cat command
if which batcat > /dev/null; then
  alias cat='batcat --style=plain'
fi

# Make aliases work even if preceded by sudo
alias sudo='sudo '

# Change apt command to nala
if which nala > /dev/null; then
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

### FUNCTIONS ###

# Git functions
function gcom {
  git add .
  git commit -m "$@"
}

function lazyg {
  git add .
  git commit -m "$@"
  git push
}

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
          *.lzma)                   unlzma ./"$n"      ;;
          *.bz2)                    bunzip2 ./"$n"     ;;
          *.cbr|*.rar)              unrar x -ad ./"$n" ;;
          *.gz)                     gunzip ./"$n"      ;;
          *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
          *.z)                      uncompress ./"$n"  ;;
          *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                                    7z x ./"$n"        ;;
          *.xz)                     unxz ./"$n"        ;;
          *.exe)                    cabextract ./"$n"  ;;
          *.cpio)                   cpio -id < ./"$n"  ;;
          *.cba|*.ace)             unace x ./"$n"      ;;
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

### OH MY ZSH PLUGINS

# sudo - hit ESC twice to run prev command with sudo or to inset sudo to currently typed command
if [ -f $XDG_CONFIG_HOME/zsh/sudo-plugin.zsh ]; then
  . $XDG_CONFIG_HOME/zsh/sudo-plugin.zsh
fi

### SETTING THE STARSHIP PROMPT ###
if which starship > /dev/null; then
  eval "$(starship init zsh)"
fi

