#!/bin/bash
                # NOTE: The shebang line exists only for syntax highlighting
                # on GitHub!

# dbbolton's zshrc

umask 022

# options
bindkey -v
setopt append_history
setopt auto_list
setopt extended_history
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt inc_append_history
setopt list_packed
setopt magic_equal_subst
setopt nonomatch



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

# keys ######################################################################
autoload zkbd
function zkbd_file() {
    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s' ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s' ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
    return 1
}

[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
keyfile=$(zkbd_file)
ret=$?
if [[ ${ret} -ne 0 ]]; then
    zkbd
    keyfile=$(zkbd_file)
    ret=$?
fi
if [[ ${ret} -eq 0 ]] ; then
    source "${keyfile}"
else
    printf 'Failed to setup keys using zkbd.\n'
fi
unfunction zkbd_file; unset keyfile ret

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Home]}"    ]]  && bindkey -M vicmd "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey -M vicmd "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

bindkey -M vicmd "^R" redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "ga" what-cursor-position



#############################################################################

chpwd () {
    local -a files
    files=( *(N) )
    FILECOUNT="$#files"
    if [[ "$FILECOUNT" -lt 10 ]]; then
        FILEPROMPT="  ${FILECOUNT}L"
    elif [[ "$FILECOUNT" -lt 100 ]]; then
        FILEPROMPT=" ${FILECOUNT}L"
    else
        FILEPROMPT="${FILECOUNT}L"
    fi
}
# call the above function to set $FILEPROMPT on login
chpwd


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

setcolors () {
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
}

setcolors

# set $VIMODE to a default value ############################################
VIMODE="$PR_RED-- INSERT --$PR_NO_COLOUR"
function zle-keymap-select {
	VIMODE="${${KEYMAP/main/$PR_RED-- INSERT --$PR_NO_COLOUR}/vicmd/$PR_LIGHT_WHITE   NORMAL   $PR_NO_COLOUR}"
	zle reset-prompt
}
zle -N zle-keymap-select

function zle-cursor {
    CURSNUM=${CURSOR}
    zle reset-prompt
}
zle -N zle-cursor

setprompt () {

    setopt prompt_subst

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
	    PR_TITLEBAR='poopoonuggets'
	    #PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	*)
	    PR_TITLEBAR=$'%n@%m:%~'
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

#PROMPT='${(e)PR_TITLEBAR}$PR_BLUE%n$PR_WHITE@$PR_RED%m$PR_WHITE:$PR_YELLOW%c$PR_WHITE%%$PR_NO_COLOUR '

# vim-like prompt

   PROMPT='
"$PR_BLUE%~$PR_NO_COLOUR" $FILEPROMPT, %?
$PR_LIGHT_YELLOW%h $VIMODE %#$PR_NO_COLOUR '

    RPROMPT='%l, $PR_BLUE%n$PR_NO_COLOUR'
}
setprompt

source $HOME/.zaliases
source $HOME/.zshenv
source /home/daniel/.zkbd/xterm-:0.0
source "$HOME/.zfunctions"
