" remember to make symlink to this file in home dir

" prevents pasting over values from being entered in the register
xnoremap p "_dP

" show line numbers
set number

" use same clipboard, need addon download
set clipboard=unnamedplus

" save bash shebang in register b. use @b to get it in vim
let @b='i#!/usr/bin/env bashq'

