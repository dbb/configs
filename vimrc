" dbbolton's .vimrc

set nocompatible " don't use vi settings

autocmd FileType text setlocal textwidth=78 " break long lines in plain text files

set autoindent " copy indentation from preceding line

set backspace=eol,start,indent " what backsapce can delete in i mode

set history=20 " keep x commands/search patterns

set hlsearch " highlight search results

set list " make tabs visible
set listchars=tab:>-,trail:-

set number " show line numbers

set ruler " show line and column of cursor
" ruler with clock
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

set showcmd " show partially entered commands
set showmode " display INSERT when in i mode
set whichwrap=h,l,~,[,],<,>
set wildmode=list:longest,full
set wrap

filetype on
syntax on

