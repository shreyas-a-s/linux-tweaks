###############################################################################
#################### --<<<-( Disable Fish Greeting )->>>-- ####################
###############################################################################

set -U fish_greeting

###############################################################################
################## --<<<-( Colors for the ls command )->>>-- ##################
###############################################################################

source ~/.config/lscolors/lscolors.csh

###############################################################################
####################### --<<<-( Autojump Config )->>>-- #######################
###############################################################################

if test -f /usr/share/autojump/autojump.fish;
    . /usr/share/autojump/autojump.fish;
end

###############################################################################
##################### --<<<-( User Defined Aliases )->>>-- ####################
###############################################################################

# "Useless" cat -> "Useless" batcat
alias cat='batcat'

# ls
alias la='lsd -A --icon never'
alias ls='lsd --icon never'
alias ll='lsd -Al --icon never --date "+%-d/%-m %H:%M" --size short --blocks permission,user,size,date,name'

# file/directory operations
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv' # (-p) create directory and parents (-v) print a message for each directory created
alias rm='trash -v'

# ShellCheck
alias shellcheck='shellcheck -x'

# apt package manager
# alias aupdate='sudo apt update'
# alias aupgrade='sudo apt upgrade -y && am -u'
# alias asearch='apt search'
# alias ashow='apt show'
# alias ainstall='sudo apt install'
# alias apurge='sudo apt purge'
# alias aautoremove='sudo apt autoremove -y'
# alias adepends='apt depends'
# alias ardepends='apt rdepends'
# alias alist='apt list'

# text editor
# alias edit='micro'
# alias sedit='sudo micro'

# history
alias history='history -R | cat -n'

# git
# alias gstatus='git status'
# alias gadd='git add'
# alias gaddu='git add -u'
# alias gcommit='git commit -m'
# alias gpush='git push'
# alias glog='git log'
# alias gfetch='git fetch'
# alias gmerge='git merge'
# alias gfetchmerge='git fetch && git merge'

# Kill a process after searching using dmenu
alias dkill='ps aux | awk \'NR!=1 {print "Process: "$11}\'  | dmenu -i -p "Search for the process to kill:" -sb "#1D7C3A" -sf "#FFFFFF" | awk \'{print $2}\' | xargs pkill -f'

###############################################################################
#################### --<<<-( User Defined Functions )->>>-- ###################
###############################################################################

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

# Make a directory (and parents if necessary) & move to that directory
function mkdirg
    mkdir -pv "$argv"
    cd "$argv"
end

# Replacement for Bash 'sudo !!' command to run last command using sudo
function sudo
    if test "$argv" = !!
        echo sudo $history[1]
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# Cuter, cooler command-not-found-handler
function __fish_command_not_found_handler --on-event fish_command_not_found
     echo "sorry, brother. I don't know any ["$argv[1]"]."
end
