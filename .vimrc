" remember to make symlink to this file in home dir


" from some video
set nocompatible
syntax enable
filetype plugin on

" finding files
set path+=**
set wildmenu


" prevents deleting / pasting over values from being entered in the register
nnoremap d "_d
xnoremap d "_d
xnoremap p "_dP

" show line numbers
set number

" search highlight
"set hlsearch
set incsearch

" use same clipboard, need addon download
set clipboard=unnamedplus

" save bash shebang in register b. use @b to get it in vim
let @b='i#!/usr/bin/env bashq'

" set permanent status bar (i hope)
set laststatus=2



" Useful shortcuts
"- Delete word undercursor in insert mode
:imap <C-d> <C-[>diwi

"- Insert Mode Movement
imap <C-b> <Esc>`^bi
imap <C-w> <Esc>`^wi
imap <C-e> <Esc>`^ei


" replace last search team 
nmap <C-s> :%s///gc<Left><Left><Left><Left>
nnoremap <F3> :%s///gc<Left><Left><Left><Left>
"nnoremap <F3> :ls<CR>


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


