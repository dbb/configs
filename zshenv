#!/bin/bash
                # NOTE: The shebang line exists only for syntax highlighting
                # on GitHub!

# debian
export DEBEMAIL="danielbarrettbolton@gmail.com"
export DEBFULLNAME="Daniel Bolton"

# directories
export CDPATH=".:~:~/source"
export obdir="$HOME/.config/openbox"
export PATH=$HOME/bin:$HOME/games/:"${PATH}"
export pd="$HOME/perl"

# files
export HISTFILE=~/.zhistory
export WWW_HOME='file:///home/daniel/Documents/home.html'

# history
export HISTSIZE=1000
export SAVEHIST=1000

# mail
export EMAIL=danielbarrettbolton@gmail.com
export MAIL=/var/spool/mail/daniel

# make
#export CFLAGS="-march=core2 -O3 -pipe -m64 -mfpmath=sse -msse -msse2 -mssse3"
export CFLAGS="-march=core2 -O2 -pipe"
export CXXFLAGS="${CFLAGS}"
export CONCURRENCY_LEVEL="2"
export MAKEFLAGS="-j 2"

# programs
export EDITOR=vim
export FILER=krusader
export PAGER=less
