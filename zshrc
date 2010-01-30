# dbbolton's zshrc

umask 022

# options
bindkey -e
setopt append_history
setopt auto_list
setopt extended_history
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt inc_append_history
setopt list_packed
setopt magic_equal_subst
setopt nonomatch

# variables
export EDITOR=vim
export HISTFILE=~/.zhistory
export HISTSIZE=1000
export PAGER=less
export SAVEHIST=1000

export WWW_HOME='file:///home/daniel/Documents/home.html'
export MAIL=/var/spool/mail/daniel

export PATH=$HOME/bin:$HOME/games/:"${PATH}"

# make stuff
export CFLAGS="-march=core2 -O3 -pipe"
export CXXFLAGS="${CFLAGS}"
export CONCURRENCY_LEVEL=2
# must comment the following line before building kernel
#export MAKEFLAGS="-j 2"

# completion
autoload -U compinit
compinit

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# setopt correctall

setopt complete_in_word
bindkey "^X^I" expand-or-complete-prefix
# bindkey "^X^H" expand-history

function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))
    
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}
    
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
	PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi

}


setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}


setprompt () {

    setopt prompt_subst

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}

    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	rxvt-unicode*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    
    if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi

# a smaller prompt
#   PROMPT='--- $PR_RED%c$PR_BLUE %%$PR_NO_COLOUR '
# older prompt, with blue user, red host, and yellow directory
#     PROMPT='$PR_BLUE%n$PR_WHITE@$PR_RED%m$PR_WHITE:$PR_YELLOW%c$PR_WHITE%%$PR_NO_COLOUR '

     PROMPT='${(e)PR_TITLEBAR}$PR_BLUE%n$PR_WHITE@$PR_RED%m$PR_WHITE:$PR_YELLOW%c$PR_WHITE%%$PR_NO_COLOUR '

}

setprompt

# Color stuff
eval "`dircolors -b`"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# apt shortcuts
alias afs='apt-file search'
alias aps='aptitude search'
alias apsrc='apt-get source'
alias apv='apt-cache policy'
alias apud='su -c "aptitude update"'
alias update='su -c "aptitude update"'
alias apug='su -c "aptitude safe-upgrade"'
alias upgrade='su -c "aptitude safe-upgrade"'

alias pingr='ping -c 2 192.168.1.1'
alias pingc='ping -c 2 comcast.net'
alias pingv='ping -c 2 verizon.net'

alias quikdeb='time dpkg-buildpackage -rfakeroot -us -uc'

# cd shortcuts
alias up='cd ..'
alias back='cd $OLDPWD'

# file-editing shortcuts
alias sz='source ~/.zshrc'
alias vz='vim ~/.zshrc ; source ~/.zshrc'
alias xdef='vim ~/.Xdefaults ; xrdb -load ~/.Xdefaults'

# find shortcuts
alias fh='find . -maxdepth 1 -iname'
alias fd='find . -iname'

# heredoc shortcut
alias 'heredoc'='cat << EOF >'

# misc
alias clear-hosts='rm -v ~/.ssh/known_hosts'
alias :q='exit'
alias kiw='kill $(pidof firefox-bin)'

# octave aliases
alias oct='octave --silent'
alias o='octave --silent --eval'

