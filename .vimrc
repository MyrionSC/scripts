"-- simple options
set nocompatible
syntax on
set relativenumber
set number " show line numbers
set showmatch " show matching item (like {})
set nowrap " Turn off line wrapping.
set scrolloff=7 " Show 7 lines of context around the cursor.
set sidescrolloff=7
set encoding=utf-8 " test this
" finding files
set path+=**
set wildmenu
set backspace=indent,eol,start
filetype plugin indent on

" search set ignorecase
set smartcase
set incsearch " search highlight
set wrapscan

" Tabs and indentation.
set tabstop=4
set shiftwidth=4
set expandtab
set expandtab
" set autoindent
" set smartindent


" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024

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
"    vim-scripts/ReplaceWithRegister
"    christoomey/vim-titlecase
"    christoomey/sort-motion
"    christommey/system-copy

Plugin 'valloric/MatchTagAlways' " highlight html tags

Plugin 'ntpeters/vim-better-whitespace' " highlight trailing whitespace (:StripWhitespace to remove)
Plugin 'maksimr/vim-jsbeautify' " jsformatting (maybe delete after a while)
Plugin 'ervandew/supertab' " tab completion in insert mode

" tab completion. Notice: Vim has to be compiled with python i think.
Plugin 'SirVer/ultisnips' " engine
Plugin 'honza/vim-snippets' " a bunch of snippets for many languages

let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsListSnippets            = '<tab><space>'
" let g:UltiSnipsExpandSnippetOrJump     = '<tab>'
" let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'

" custom snippets dir. Remember to make symlink to ~/bin/ultisnippets in .vim
let g:UltiSnipsSnippetsDir             = '~/bin/ultisnippets'
let g:UltiSnipsSnippetDirectories      = ["UltiSnips", "ultisnippets"]
let g:UltiSnipsEditSplit               = 'vertical'


" all vundle plugins must be added before this line
call vundle#end()                       " required
filetype plugin indent on               " required

" -----------
" PLUGINS END
" -----------


" remap leader to space
let mapleader = ' '

" edit vimrc from vim
nmap <leader>v :tabe ~/.vimrc<CR>
autocmd bufwritepost .vimrc source ~/.vimrc

" exit insert mode from homebar
inoremap jk <ESC>
inoremap kj <ESC>

" prevents deleting / pasting over values from being entered in the register
nnoremap d "_d
xnoremap d "_d
nnoremap D "_D
xnoremap D "_D
xnoremap p "_dP

" cut into vim default register
nnoremap X ""D

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
" navigate in windows with ctrl-hjkl
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" move lines with Ctrl + (Shift) +J/K
nnoremap <C-j> :m +1<CR>
nnoremap <C-k> :m -2<CR>
inoremap <C-j> <Esc>:m +1<CR>gi
inoremap <C-k> <Esc>:m -2<CR>gi
vnoremap <C-j> :m '>+1<CR>gvgv
vnoremap <C-k> :m '<-2<CR>gvgv

" insert four space
inoremap <leader><tab> <space><space><space><space>

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
set tags=.git/tags,tags
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

" system clipboard
if g:os == "Linux"
   vmap <leader>y "+y
   vmap <leader>d "+d
   vmap <leader>p "+p
   vmap <leader>P "+P
   nmap <leader>y "+yy
   nmap <leader>Y vf$"+y
   nmap <leader>p "+p
   nmap <leader>P "+P
   nmap <leader>D "+d
   nmap <leader>X "+D
elseif g:os == "Darwin" " mac
   vmap <leader>y "*y
   vmap <leader>d "*d
   vmap <leader>p "*p
   vmap <leader>P "*P
   nmap <leader>y "*yy
   nmap <leader>Y vf$"*y
   nmap <leader>p "*p
   nmap <leader>P "*P
   nmap <leader>D "*d
   nmap <leader>X "*D
elseif g:os == "MSYS_NT-10.0-18362"
   vmap <leader>y "*y
   vmap <leader>d "*d
   vmap <leader>p "*p
   vmap <leader>P "*P
   nmap <leader>y "*yy
   nmap <leader>Y vf$"*y
   nmap <leader>p "*p
   nmap <leader>P "*P
   nmap <leader>D "*d
   nmap <leader>X "*D
endif

" Execute macros over multiple visual lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

