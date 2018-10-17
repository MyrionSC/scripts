" remember to make symlink to this file in home dir

" prevents pasting over values from being entered in the register
xnoremap p "_dP

" show line numbers
set number

" use same clipboard, need addon download
set clipboard=unnamedplus

" save bash shebang in register b. use @b to get it in vim
let @b='i#!/usr/bin/env bashq'

" set permanent status bar (i hope)
set laststatus=2

" trying out some status lines
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%b,0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset


