" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

filetype plugin indent on


if has("syntax")
  syntax on
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//
set backup

"vim7.3
" set mapleader = ","

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set modelines=0
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
" vim7.3
" set colorcolumn=85
" set relativenumber
" set undofile

nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set tabstop=2
set softtabstop=2
set sw=2
set expandtab
set autoindent
set smarttab
set linebreak
set smartindent
set wrap
set sr
set title
set visualbell
set noerrorbells

" Fuck you too, manual key.
nnoremap K <nop>

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <right> <Esc>gt
map <left> <Esc>gT

""""""""""""""""""""""""""""""
" => Spacing shit section
""""""""""""""""""""""""""""""
map <Leader>t8 :set ts=8 sts=8 sw=8 noexpandtab autoindent smartindent<CR>
map <Leader>t4 :set ts=4 sts=4 sw=4 noexpandtab autoindent smartindent<CR>
map <Leader>s4 :set ts=4 sts=4 sw=4 expandtab autoindent smartindent<CR>
map <Leader>s2 :set ts=2 sts=2 sw=2 expandtab autoindent smartindent<CR>


""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au BufNewFile,BufRead *.test set ft=php
au BufNewFile,BufRead *.module set ft=php
au BufNewFile,BufRead *.install set ft=php

au BufNewFile,BufRead *.txt map j gj
au BufNewFile,BufRead *.txt map k gk
au BufNewFile,BufRead *.txt set nocursorline

""""""""""""""""""""""""""""""
" => PHP section
""""""""""""""""""""""""""""""
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.engine set filetype=php
  augroup END
endif

"""
" Nerd Tree
"""
map <Leader>tr :NERDTree<CR>
map <Leader>tc :NERDTreeClose<CR>

map <Leader>nw :%s/^\ *//g<CR>
map <Leader>ni :set noautoindent nosmartindent<CR>:filetype plugin indent off<CR>

set bg=light
set tags=./tags;/

"cscope file-searching alternative
function SetCscope()
  let curdir = getcwd()
  while !filereadable("cscope.out") && getcwd() != "/" 
    cd ..
  endwhile
  if filereadable("cscope.out")
    execute "cs add " . getcwd() . "/cscope.out" 
  endif
  execute "cd " . curdir
endfunction

if has("cscope")
  call SetCscope()
endif

map <SPACE> w

" use w!! to write file with sudo
map w!! w !sudo tee % >/dev/null

" folding and stuff
let php_sql_query = 1
let php_htmlInStrings = 1
let php_parent_error_close = 1
let php_parent_error_open = 1
let php_folding = 1

set smartindent
