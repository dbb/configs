# debian
export DEBEMAIL="danielbarrettbolton@gmail.com"
export DEBFULLNAME="Daniel Bolton"

# directories
export CDPATH=".:~:~/source"
export gh="$HOME/src/github"
export ob="$HOME/.config/openbox"
export nes="/mnt/media_files/games/nes"
export pd="$HOME/perl"

# files
export HISTFILE="$HOME/.zhistory"
export WWW_HOME='file:///home/daniel/Documents/home.html'

# history
export HISTSIZE=1000
export SAVEHIST=1000

# less
export LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'

# mail
export EMAIL='danielbarrettbolton@gmail.com'
export MAIL='/var/spool/mail/daniel'

# make
#export CFLAGS="-march=core2 -O3 -pipe -m64 -mfpmath=sse -msse -msse2 -mssse3"
export CFLAGS='-march=core2 -O2 -pipe'
export CXXFLAGS="${CFLAGS}"
export CONCURRENCY_LEVEL='2'
export MAKEFLAGS='-j 2'

# path
typeset -U path
for dir in ~/bin ~/games; do
    if [[ -z ${path[(r)$dir]} ]]; then
        path=($dir $path)
    fi
done

# programs
export EDITOR=vim
export PAGER=less
export VISUAL=vim

# characters that are not part of a word
WORDCHARS=${WORDCHARS//[-]}

