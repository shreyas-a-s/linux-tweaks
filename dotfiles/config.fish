### DISABLE GREETING ###
set -U fish_greeting

### SET XDG USER DIRECTORES ###
 set -gx XDG_CONFIG_HOME $HOME/.config
 set -gx XDG_CACHE_HOME $HOME/.cache
 set -gx XDG_DATA_HOME $HOME/.local/share
 set -gx XDG_STATE_HOME $HOME/.local/state

### EXPORT ###
 set TERM "xterm-256color"                         # getting proper colors
 set -gx WGETRC $XDG_CONFIG_HOME/wgetrc            # set xdg base directory for wget
 set LESSHISTFILE -                                # prevent creation of ~/.lesshst file
if which nvim > /dev/null
  set EDITOR "nvim"
  set VISUAL "nvim"
  set SUDO_EDITOR "nvim"
end

# Set colors for ls command
if [ -f "$HOME/.config/lscolors/lscolors.csh" ]
  . $XDG_CONFIG_HOME/lscolors/lscolors.csh
end

#### SET MANPAGER ###
if which batcat > /dev/null
  set -x MANPAGER "sh -c 'col -bx | batcat -l man -p'"
end

### PATH ###
if [ -d "$HOME/.bin" ]
  set -Ux PATH "$HOME/.bin:$PATH"
end

if [ -d "$HOME/.local/bin" ]
  set -Ux PATH "$HOME/.local/bin:$PATH"
end

if [ -d "$HOME/Applications" ]
  set -Ux PATH "$HOME/Applications:$PATH"
end

if [ -d "/var/lib/flatpak/exports/bin/" ]
  set -Ux PATH "/var/lib/flatpak/exports/bin/:$PATH"
end  

if [ -d "/usr/games/" ] ;
  set -Ux PATH "/usr/games/:$PATH"
end

### ALIASES ###

# To select correct neovim
if which nvim > /dev/null
  alias vim='nvim'
else if flatpak list | grep nvim > /dev/null
  alias vim='flatpak run io.neovim.nvim'
end

# To set XDG Base Directory for wget
[ -f $XDG_CONFIG_HOME/wgetrc ] || touch $XDG_CONFIG_HOME/wgetrc && alias wget='wget --hsts-file=$XDG_CACHE_HOME/wget-hsts'

# Update all packages on system
alias allup='sudo apt update && sudo apt upgrade -y; flatpak update -y; which neovim-appimage-updater > /dev/null && neovim-appimage-updater'

# Tree command - Show all files including hidden ones
alias tree='tree -a'

# Better ls commands
if which lsd > /dev/null
  alias ls='lsd -A'
  function ll
    if [ -z "$argv" ] && [ "$argv[1]" = "-g" ]
      set -e argv[1]
      lsd -Al --blocks permission,user,group,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first $argv
    else
      lsd -Al --blocks permission,user,size,date,name --date +%d\ %b\ %H:%M --size short --group-directories-first $argv
    end
  end
  alias lt='lsd --tree --group-directories-first'
else
  alias ls='ls -A --color=auto --group-directories-first'
  alias ll='ls -Alh --color=auto --group-directories-first'
  alias lt='tree --dirsfirst'
end

# Colorize grep output (good for log files)
alias grep='grep -i --color=auto'
alias egrep='grep -e'
alias fgrep='grep -f'
alias rgrep='grep -r'

# Adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB

# Add verbose output to cp, mv & mkdir
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Enable command-line trash
if [ -f "/usr/bin/trash" ]
  alias rm='trash'
end

# Colorize cat command
if which batcat > /dev/null
  alias cat='batcat --style=plain'
end

# Allows shellcheck to follow any file the script may source
alias shellcheck='shellcheck -x'

# Force start btop even if no UTF-8 locale was detected
alias btop='btop --utf-force'

# Making history show numbers like other shells
alias history='history -R | command cat -n'

### RANDOM COLOR SCRIPT ###
# Get this script from my Github: github.com/shreyas-a-s/shell-color-scripts
if which colorscript > /dev/null
  colorscript random
end

### AUTOJUMP ###
if [ -f /usr/share/autojump/autojump.fish ]
  . /usr/share/autojump/autojump.fish
end

### FUNCTIONS ###

# Git functions
function gcom
  git add .
  git commit -m "$argv"
end

function lazyg
  git add .
  git commit -m "$argv"
  git push
end

# Create and go to the directory
function mkdircd
  mkdir -pv "$argv"
  cd "$argv"
end

# Replacing 'apt' with 'nala' and 'sudo vim' with 'sudoedit'
function sudo
  if [ "$argv[1]" = "apt" ] && [ (which nala > /dev/null; echo $status) -eq 0 ]
    set argv[1] nala && command sudo $argv
  else if [ "$argv[1]" = "vim" -a (type vim > /dev/null; echo $status) -eq 0 ]
    set -e argv[1]
    set tempvar "$SUDO_EDITOR" && set SUDO_EDITOR vim
    sudoedit $argv
    set SUDO_EDITOR "$tempvar" && set -e tempvar
  else
    command sudo $argv
  end
end

# My Ping ;)
function ping
  if [ -z "$argv[1]" ]
    command ping -c 1 example.org
  else
    command ping $argv
  end
end

# Function to use ix.io (the command-line pastebin)
function ix
  curl -F "f:1=@$argv[1]" ix.io
end

### OH MY FISH PLUGINS ###

# plugin-band-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function _plugin-bang-bang_key_bindings --on-variable fish_key_bindings
    bind --erase !
    bind --erase '$'
    switch "$fish_key_bindings"
    case 'fish_default_key_bindings'
        bind --mode default ! __history_previous_command
        bind --mode default '$' __history_previous_command_arguments
    case 'fish_vi_key_bindings' 'fish_hybrid_key_bindings'
        bind --mode insert ! __history_previous_command
        bind --mode insert '$' __history_previous_command_arguments
    end
end

function _plugin-bang-bang_uninstall --on-event plugin-bang-bang_uninstall
    bind --erase !
    bind --erase '$'
    functions --erase _plugin-bang-bang_uninstall
end

_plugin-bang-bang_key_bindings

### SETTING THE STARSHIP PROMPT ###
if which starship > /dev/null
  starship init fish | source
end
