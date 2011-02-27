" dbbolton's .vimrc

" don't use vi settings
set nocompatible

" diff options
set diffopt=vertical,iwhite,filler
set scrollbind

command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
	 	\ | wincmd p | diffthis



" break long lines in plain text files
autocmd FileType text setlocal textwidth=78

" copy indentation from preceding line
set autoindent

" what backsapce can delete in i mode
set backspace=eol,start,indent

" keep x commands/search patterns
set history=20

"set hlsearch " highlight search results

set mouse=a " mouse support"

" show line numbers relative to current line
"set relativenumber
set number

" create .un~ file
set undofile


" ruler with clock
" set rulerformat=%55(%{strftime('%a\ %b\ %e\ %I:%M\ %p')}\ %5l,%-6(%c%V%)\ %P%)

" status bar etc ------------------------------------------------------------
set ruler       " show line and column of cursor
set showcmd
set showmode
set ls=2        " always show status bar
"set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
set statusline=%<%1*===\ %5*%f%1*%(\ ===\ %4*%h%1*%)%(\ ===\ %4*%m%1*%)%(\ ===\ %4*%r%1*%)\ ===%====\ %2*%b(0x%B)%1*\ ===\ %3*%l,%c%V%1*\ ===\ %5*%P%1*\ ===%0*

set showcmd " show partially entered commands
set showmode " display INSERT when in i mode
set whichwrap=h,l,~,[,],<,>
set wildmode=list:longest,full
set wrap

" allow pasting in the console
"set paste

syntax on


" force a file's syntax highlighting type
au BufNewFile,BufRead .vimperatorrc setf vim


" extra bindings ------------------------------------------------------------
let mapleader = ","
let g:mapleader = ","

nmap <leader>a A 
nmap <leader>c I#<Esc>
nmap <leader>d :close<CR>
nmap <leader>e :colo 
nmap <leader>h iprint <<'EOF';<CR><Esc>
nmap <leader>r @:
nmap <leader>s ddpk
nmap <leader>v "+gP<CR>
nmap <leader>w :w!<CR>

nmap <leader>I ^i <Esc>i

nmap <leader>$ f$li
nmap <leader>@ f@li
nmap <leader>; A;<Esc>^


nmap <leader># i#!/usr/bin/env perl<CR>use strict;
    \<CR>use warnings;<CR><esc>:set filetype=perl<ENTER>i<CR>

" maps that override default commands
nmap t :tabnew 
"map <leader>e :e! ~/.vimrc<cr>
autocmd! bufwritepost vimrc source ~/.vimrc
" ---------------------------------------------------------------------------

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


function! CurDir()
    let curdir = substitute(getcwd(), '/home/daniel/', "~/", "g")
    return curdir
endfunction

colorscheme lucius88

" pthogen
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" turn filetype back on
filetype on
filetype plugin on
filetype indent on

" custom function
"function DarkDefault()
"    colo default
"    set background=dark
"    hi Normal guibg=black guifg=white
"endfunction

