" remember to make symlink to this file in home dir


" from some video
set nocompatible
syntax on
filetype off
set encoding=utf-8 " test this
" filetype plugin on


" -------
" PLUGINS
" -------


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim	"required
call vundle#begin()			"required

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-repeat'

" python autocompletion
Plugin 'davidhalter/jedi-vim'

" add some plugins from https://www.youtube.com/watch?v=wlR5gYd6um0
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
"    vim-scripts/ReplaceWithRegister
"    christoomey/vim-titlecase
"    christoomey/sort-motion
"    christommey/system-copy


call vundle#end()            " required
filetype plugin indent on    " required

" -----------
" PLUGINS END
" -----------

" remap leader to space
let mapleader = ' ' 

" finding files
set path+=**
set wildmenu


" prevents deleting / pasting over values from being entered in the register
nnoremap d "_d
xnoremap d "_d
xnoremap p "_dP

"-- simple options
set relativenumber
set number " show line numbers
set showmatch " show matching item (like {})
set nowrap " Turn off line wrapping.
set scrolloff=7 " Show 7 lines of context around the cursor.
set sidescrolloff=7


" search
set ignorecase
set smartcase
set incsearch " search highlight
set wrapscan

" Tabs and indentation.
set expandtab
set autoindent
set smartindent


" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024


" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Go to first and last char of current line easier
noremap H ^
noremap L $

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

set laststatus=2 " set permanent status bar (i hope)

" use same clipboard, need addon download
set clipboard=unnamedplus

" save bash shebang in register b. use @b to get it in vim
let @b='i#!/usr/bin/env bashq'

" Useful shortcuts
"- Delete word undercursor in insert mode
:imap <C-d> <C-[>diwi

"- Insert Mode Movement
imap <C-b> <Esc>`^bi
imap <C-w> <Esc>`^wi
imap <C-e> <Esc>`^ei

" windows
set splitbelow splitright
" nagigate in windows with ctrl-hjkl
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" replace last search team 
nmap <C-s> :%s///gc<Left><Left><Left><Left>
nnoremap <F3> :%s///gc<Left><Left><Left><Left>

" save readonly file changes
cmap w!! w !sudo tee >/dev/null %


" jedi-vim
let g:jedi#auto_initialization = 1






" Status line ------------------------------------------------------
"set laststatus=2
"
"" Show (partial) command in the status line
"set showcmd
"
"augroup ft_statuslinecolor
"    au!
"
"    au InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
"    au InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
"augroup END
"
"set statusline=%f       " Path.
"set statusline+=%m      " Modified flag.
"set statusline+=%r      " Readonly flag.
"set statusline+=%w      " Preview window flag
"
"set statusline+=\       " Space.
"
"set statusline+=%=   " Right align.
"
"" File format, encoding and type.  Ex: "(unix/utf-8/python)"
"set statusline+=(
"set statusline+=%{&ff}                        " Format (unix/DOS).
"set statusline+=/
"set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
"set statusline+=/
"set statusline+=%{&ft}                        " Type (python).
"set statusline+=)
"
"" Line and column position and counts.
"set statusline+=\ (line\ %l\/%L,\ col\ %03c)




" trying out some status lines
"set statusline=   " clear the statusline for when vimrc is reloaded
"set statusline+=%-3.3n\                      " buffer number
"set statusline+=%f\                          " file name
"set statusline+=%h%m%r%w                     " flags
"set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
"set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
"set statusline+=%{&fileformat}]              " file format
"set statusline+=%=                           " right align
"set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
"set statusline+=%b,0x%-8B\                   " current char
"set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset


