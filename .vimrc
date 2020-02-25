"-- simple options
set nocompatible
syntax on
set relativenumber
set number " show line numbers
set showmatch " show matching item (like {})
set nowrap " Turn off line wrapping.
set scrolloff=10 " Show 7 lines of context around the cursor.
set sidescrolloff=10
set encoding=utf-8 " test this
" finding files
set path+=**
set wildmenu
set backspace=indent,eol,start
filetype plugin indent on

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.bmp,*.tiff
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

" Ask for confirmation when handling unsaved or read-only files
set confirm

" Do not use visual and error bells
set novisualbell noerrorbells

" search set ignorecase
set smartcase
set incsearch " search highlight
set wrapscan

" Tabs and indentation.
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set expandtab
" set autoindent
" set smartindent

" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>

" Break line at predefined characters
set linebreak
" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" Do not add two space after a period when joining lines or formatting texts,
" see https://tinyurl.com/y3yy9kov
set nojoinspaces

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024

" remap leader to space
let mapleader = ' '


" -------
" PLUGINS
" -------

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim	"required
call vundle#begin()			"required
Plugin 'VundleVim/Vundle.vim'           "required

Plugin 'tpope/vim-repeat'

" add some plugins from https://www.youtube.com/watch?v=wlR5gYd6um0
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'

Plugin 'justinmk/vim-sneak'

" typescript highlighting
Plugin 'leafgarland/typescript-vim'
autocmd BufNewFile,BufRead *.ts  set filetype=typescript
autocmd BufNewFile,BufRead *.tsx setfiletype typescript

" highlight html tags
Plugin 'valloric/MatchTagAlways'

" navigate filesystem in vim
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
com! NT NERDTree

" fuzzy search
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'ntpeters/vim-better-whitespace' " highlight trailing whitespace (:StripWhitespace to remove)
Plugin 'maksimr/vim-jsbeautify' " jsformatting (maybe delete after a while)

nmap <leader>f :CtrlP<CR>
nmap <leader>b :CtrlBuffer<CR>

" Snippets! Notice: Vim has to be compiled with python i think.
Plugin 'ervandew/supertab' " tab completion in insert mode
Plugin 'ycm-core/YouCompleteMe' " contextual completion engine (remember to compile)
Plugin 'SirVer/ultisnips' " snippets engine
Plugin 'honza/vim-snippets' " a bunch of snippets for many languages

" Expand snippets with ctrl-enter (might be different on windows). Also jumps forward in snippets
let g:UltiSnipsExpandTrigger="<C-J>"

" custom snippets dir. Remember to make symlink to ~/bin/ultisnippets in .vim
" let g:UltiSnipsSnippetsDir             = '~/bin/ultisnippets'
" let g:UltiSnipsSnippetDirectories      = ["UltiSnips", "ultisnippets"]
" let g:UltiSnipsEditSplit               = 'vertical'


" all vundle plugins must be added before this line
call vundle#end()                       " required
filetype plugin indent on               " required

" Plugins TODO:
" - Test out CamelCaseMotion
" - Fix snippets

" -----------
" PLUGINS END
" -----------

map <C-s> :w

" === Buffers
" print buffers and prepare to go to one
nnoremap gb :ls<cr>:b<space>
" load all files in dir and subdirs into buffers
com! LoadBuffers :args `rg --hidden --files`
" save all buffers. If not able to, like if unnamed file exists, write message
nnoremap <silent> <C-m> :try\|wa\|catch /\<E141\>/\|echomsg 'Not all files saved!'\|endtry<CR>

" edit vimrc from vim
nmap <leader>v :tabe ~/.vimrc<CR>
autocmd bufwritepost .vimrc source ~/.vimrc

" exit insert mode from homebar
inoremap jk <ESC>
inoremap kj <ESC>
noremap! <silent> <C-l> <ESC>
vnoremap <silent> <C-l> <ESC>
onoremap <silent> <C-l> <ESC>

" prevents deleting / pasting over values from being entered in the register
nnoremap d "_d
nnoremap D "_D
" xnoremap d "_d
" xnoremap D "_D
" xnoremap p "_dP
" xnoremap P "_dP
vnoremap d "_d
vnoremap c "_di
vnoremap p "_dP
vnoremap P "_dP

" remap search
vnoremap <leader>j /
nnoremap <leader>j /
vnoremap <leader>k ?
nnoremap <leader>k ?
nnoremap æ /
nnoremap Æ ?
vnoremap æ /
vnoremap Æ ?
cnoremap æ <ENTER>

" cut into vim default register
nnoremap X ""dd

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" set folder for .swp files (has to be created manually)
" set backupdir=/home/mar/.vim/backup
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

" Go to first and last char of current line easier
noremap H ^
noremap L $

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

set laststatus=2 " set permanent status bar (i hope)

" save bash shebang in register b. use @b to get it in vim
let @b='i#!/usr/bin/env bashq'

" Useful shortcuts
"- Delete word undercursor in insert mode
" imap <C-d> <C-[>diwi
inoremap <C-d> <C-[>diwi

"- Insert Mode Movement
imap <C-b> <Esc>`^bi
imap <C-w> <Esc>`^wi
imap <C-e> <Esc>`^ei

" windows
set splitbelow splitright
" navigate in windows with ctrl-hjkl
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" Resize windows using <Alt> and h,j,k,l, inspiration from
" https://goo.gl/vVQebo (bottom page).
" If you enable mouse support, shorcuts below may not be necessary.
nnoremap <silent> <M-h> <C-w><
nnoremap <silent> <M-l> <C-w>>
nnoremap <silent> <M-j> <C-W>-
nnoremap <silent> <M-k> <C-W>+

" move lines with Ctrl + (Shift) +J/K
nnoremap <C-j> :m +1<CR>
nnoremap <C-k> :m -2<CR>
inoremap <C-j> <Esc>:m +1<CR>gi
inoremap <C-k> <Esc>:m -2<CR>gi
vnoremap <C-j> :m '>+1<CR>gvgv
vnoremap <C-k> :m '<-2<CR>gvgv

" insert four space
" inoremap <leader><tab> <space><space><space><space>

" file operations
" nmap <C-l> @:
" nmap <C-w> :w<CR>
" map <C-q> :q<CR>

" reformat command " TODO: set mark to return to same position
" command Reformat gg=G

" replace last search team
" nmap <C-s> :%s///gc<Left><Left><Left><Left>
" nnoremap <F3> :%s///gc<Left><Left><Left><Left>

" save readonly file changes
cmap w!! w !sudo tee >/dev/null %

" jedi-vim
" let g:jedi#auto_initialization = 1

" ctags keybind
set tags=tags
nmap <leader>T :!ctags -R .<CR><CR>

" todo: test Ctrlp
" nnoremap <leader>. :CtrlPTag<cr>

" todo: test Tagbar
" nnoremap <silent> <Leader>b :TagbarToggle<CR>

" Custom operating system settings
if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

" use system clipboard multiplatform
"set clipboard^=unnamed,unnamedplus

" system clipboard
if g:os == "Linux"
   vmap <leader>y "+y
   vmap <leader>d "+d
   vmap <leader>x "+x
   vmap <leader>p "+p
   vmap <leader>P "+P
   nmap <leader>y "+yy
   nmap <leader>Y vf$"+y
   nmap <leader>p "+p
   nmap <leader>P "+P
   nmap <leader>D "+d
   nmap <leader>X "+dd
elseif g:os == "Darwin" " mac
   vmap <leader>y "*y
   vmap <leader>d "*d
   vmap <leader>x "*x
   vmap <leader>p "*p
   vmap <leader>P "*P
   nmap <leader>y "*yy
   nmap <leader>Y vf$"*y
   nmap <leader>p "*p
   nmap <leader>P "*P
   nmap <leader>D "*d
   nmap <leader>X "*dd
elseif g:os == "MSYS_NT-10.0-18362"
   vmap <leader>y "*y
   vmap <leader>d "*d
   vmap <leader>x "*x
   vmap <leader>p "*p
   vmap <leader>P "*P
   nmap <leader>y "*yy
   nmap <leader>Y vf$"*y
   nmap <leader>p "*p
   nmap <leader>P "*P
   nmap <leader>D "*d
   nmap <leader>X "*dd
endif

" Execute macros over multiple visual lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Display a message when the current file is not in utf-8 format.
" Note that we need to use `unsilent` command here because of this issue:
" https://github.com/vim/vim/issues/4379
augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8'
                \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END


" ====== STATUS LINE SETTINGS
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'no' : 'N·Operator Pending ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \ 'cv' : 'Vim Ex ',
       \ 'ce' : 'Ex ',
       \ 'r'  : 'Prompt ',
       \ 'rm' : 'More ',
       \ 'r?' : 'Confirm ',
       \ '!'  : 'Shell ',
       \ 't'  : 'Terminal '
       \}

set statusline=
set statusline+=\ %{toupper(g:currentmode[mode()])}   " Current mode
set statusline+=\|

" Truncate line here
set statusline+=\ %<

" File path, as typed or relative to current directory
set statusline+=%f

set statusline+=\ %{&modified?'[+]':''}
set statusline+=%{&readonly?'[]':''}

set statusline+=%{&spell?'[SPELL]':''}
set statusline+=%#WarningMsg#
set statusline+=%{&paste?'[PASTE]':''}
set statusline+=%*

" Separation point between left and right aligned items
set statusline+=%=

set statusline+=%-5{&filetype!=#''?&filetype:'none'}

" Encoding & Fileformat
set statusline+=%#WarningMsg#
set statusline+=%{&fileencoding!='utf-8'?'['.&fileencoding.']':''}
set statusline+=%*

set statusline+=[%{&fileformat}]

" Warning about byte order
set statusline+=%#WarningMsg#
set statusline+=%{&bomb?'[BOM]':''}
set statusline+=%*

" Location of cursor line
set statusline+=\ [%l/%L\ %2p%%]

" Column number
set statusline+=\ col:%3c

highlight StatusLine ctermfg=2

" format xml using xmllint, TODO: test it
" com! FormatXML !xmllint --format -<CR>

" remove front whitespace
"com! RemoveFrontWhitespace :%s/^[\t ]*//g
"com! RemoveBackWhitespace :%s/\s\+$//e
com! RemoveFrontBackWhitespace :%s/^\s\+//e | %s/\s\+$//e
com! TrimWhitespace :%s/^\s\+//e | %s/\s\+$//e
com! RemoveEmptyLines :g/^\s*$/d

com! TryCamelCase :%!xargs -n1 -I{} sh -c 'camelcase {}'

" ====== FORMAT STUFF

" must have jq installed
com! FormatJSON :%!jq '.'

" discount xml format, slow on big stuff
com! FormatXML :%s/</\r</g || norm gg=G

" reformat html: gq<motion> (reformat line example: gql)
autocmd FileType html
\ setlocal formatprg=tidy\ -indent\ -quiet\ --show-errors\ 0\ --tidy-mark\ no\ --show-body-only\ auto


" commentor create csharp class from boomi profile (needs reformated html)
com! -bar FindTitle :v/title/d
com! -bar ExtractTitle :%norm 0/titlee3ld0elD
com! -bar FirstCharUpper :%s/\<\(\w\)\(\w*\)\>/\u\1\L\2/ge
com! -bar CamelCase  :%s#\%(\%(\k\+\)\)\@<=_\(\k\)#\u\1#ge
com! -bar Text2CSharpProp :g/./norm Ipublic string A { get; set; }
com! BoomiToCSharp FindTitle | ExtractTitle | FirstCharUpper | CamelCase | Text2CSharpProp
com! PlaceholdersToTypes :%s/s$/string/ge | :%s/n$/int/ge | :%s/d$/DateTime/ge | :%s/b$/bool/ge
com! GenerateMapper :%norm yiwIto.La = from.pa;


" translate text (needs trans-shell: wget git.io/trans)
com! -bar TranslateDaEn :%!trans -d -b da:en

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" visual studio vim rebinds (enter with : )
" nnoremap Xae _iAssert.AreEqual();<ENTER><ESC>kf)
" inoremap jk <ESC>
" nnoremap æ /
" nnoremap Æ ?
" vnoremap æ /
" vnoremap Æ ?
" nnoremap X ""dd

