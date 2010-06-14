" dbbolton's .vimrc

" don't use vi settings
set nocompatible

" break long lines in plain text files
autocmd FileType text setlocal textwidth=78

" copy indentation from preceding line
set autoindent

" what backsapce can delete in i mode
set backspace=eol,start,indent

" keep x commands/search patterns
set history=20

set hlsearch " highlight search results


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

filetype plugin on
filetype indent on

au BufNewFile,BufRead .vimperatorrc setf vim


" extra bindings
let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>

map <leader>e :e! ~/.vimrc<cr>
autocmd! bufwritepost vimrc source ~/.vimrc


" tabs
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab

set list " make tabs visible
set listchars=tab:>-,trail:-

" the other kind of tabs
nmap <leader>n :tabNext<cr>
nmap <leader>p :tabprevious<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/home/daniel/', "~/", "g")
    return curdir
endfunction

" gvim stuff
if has("gui_running")
    set lines=31 columns=83
    colors mustang
    set background=dark
    set guioptions-=T
    set showtabline=2
endif
