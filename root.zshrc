#!/bin/bash
                # NOTE: The shebang line exists only for syntax highlighting
                # on GitHub!

# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history

autoload -U compinit
compinit

bindkey -e

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
        eval PR_$color="%{$terminfo[bold]$fg[${(L)color}]%}" 
        eval PR_LIGHT_$color="%{$fg[${(L)color}]%}"          
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
            PR_TITLEBAR=$'%{\e]0;%(!.***ROOT.)@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'                                                                        
            ;;                                                                     
        screen)                                                                    
            PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.***[ROOT]*** | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'                                                    
            ;;                                                                     
        *)                                                                         
            PR_TITLEBAR=""                                                         
            ;;                                                                     
    esac                                                                           
                                                                                   
    if [[ "$TERM" == "screen" ]]; then                                             
        PR_STITLE=$'%{\ekzsh\e\\%}'                                                
    else                                                                           
        PR_STITLE=""                                                               
    fi                                                                             

    PROMPT='${(e)PR_TITLEBAR}$PR_GREEN%n$PR_NO_COLOUR@%m:%c$PR_GREEN%#$PR_NO_COLOUR '
}                                                                                  

setprompt

source '/root/.zaliases'
source '/root/.zfunctions'
