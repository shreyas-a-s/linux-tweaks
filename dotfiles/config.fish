### DISABLE GREETING ###
set -U fish_greeting

### EXPORT ###
setenv TERM "xterm-256color" # getting proper colors
if [ -f /usr/bin/micro ]
  setenv EDITOR "micro"
  setenv VISUAL "micro"
end

#### SET MANPAGER ###
setenv MANPAGER "sh -c 'col -bx | batcat -l man -p'"

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

# Changing "ls" to "exa"
if [ -f "/usr/bin/exa" ]
  alias ls='exa -a --color=always --group-directories-first'  # all files and dirs
  alias ll='exa -al --color=always --group-directories-first' # my preferred listing
  alias lt='exa -aT --color=always --group-directories-first' # tree listing
else
  alias ls='ls --color=auto'
  alias la='ls -A --color=auto'
  alias ll='ls -alh --color=auto'
end

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
if [ -f "/usr/bin/trash" ]
  alias rm='trash'
end

# Colorize cat command
if [ -f "/usr/bin/batcat" ]
  alias cat='batcat --style=plain'
end

# Allows shellcheck to follow any file the script may source
alias shellcheck='shellcheck -x'

# Force start btop even if no UTF-8 locale was detected
alias btop='btop --utf-force'

# Making history show numbers like other shells
alias history='history -R | cat -n'

### RANDOM COLOR SCRIPT ###
# Get this script from my Github: github.com/shreyas-a-s/shell-color-scripts
if [ -f /usr/local/bin/colorscript ]
  bash colorscript random
end

### AUTOJUMP ###
if [ -f /usr/share/autojump/autojump.fish ]
  . /usr/share/autojump/autojump.fish
else
  echo "Can't find the autojump script"
end

# Set colors for ls command
if [ -f "$HOME/.config/lscolors/lscolors.csh" ]
  source ~/.config/lscolors/lscolors.csh
end

### FUNCTIONS ###

# Extract all types of archive file formats
function extract
  set archiveextension (echo "$argv" | awk -F . {'print $NF'})
  set archiveextensionprefix (echo "$argv" | awk -F . {'print $(NF-1)'})
  switch $archiveextension
	case bz2
	  if [ "$archiveextensionprefix" = "tar" ]
		tar xjf "$argv"
	  else
		bunzip2 "$argv"
	  end
	case gz
	  if [ "$archiveextensionprefix" = "tar" ]
		tar xzf "$argv"
	  else
		gunzip "$argv"
	  end
	case rar
		unrar x "$argv"
	case tar
		tar xf "$argv"
	case tbz2
		tar xjf "$argv"
	case tgz
		tar xzf "$argv"
	case zip
		unzip "$argv"
	case Z
		uncompress "$argv"
	case 7z
		7z x "$argv"
	case deb
		ar x "$argv"
	case xz
		tar xf "$argv"
	case zst
		unzstd "$argv"
	case '*'
		echo "sorry, brother. I have no idea what you are trying to extract."
  end
end

# Create and go to the directory
function mkdircd
  mkdir -pv "$argv"
  cd "$argv"
end

# Replacement for Bash 'sudo !!' command & replacing 'apt' with 'nala'
function sudo
  if [ "$argv" = !! ]
	echo sudo $history[1]
	eval command sudo $history[1]
  else if [ "$argv[1]" = apt -a -f /usr/bin/nala ]
	set argv[1] nala && command sudo $argv
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

### SETTING THE STARSHIP PROMPT ###
if [ -f /usr/local/bin/starship ]
  starship init fish | source
end