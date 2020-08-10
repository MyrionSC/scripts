
# Custome UltiSnips snippets

snippets in this dir is on top of snippets in ~/.vim/bundle/vim-snippets/UltiSnips

ctrl-enter to expand snippet. ctrl-enter as well to jump inside snippet.


## Ultisnips setup in vimrc

Plugin 'ervandew/supertab' " tab completion in insert mode
Plugin 'ycm-core/YouCompleteMe' " contextual completion engine (remember to compile)
Plugin 'SirVer/ultisnips' " snippets engine
Plugin 'honza/vim-snippets' " a bunch of snippets for many languages

" Expand snippets with ctrl-enter (might be different on windows). Also jumps forward in snippets
let g:UltiSnipsExpandTrigger="<C-J>"

" custom snippets dir. Remember to make symlink to ~/bin/ultisnippets in .vim
let g:UltiSnipsSnippetsDir             = '~/bin/ultisnippets'
let g:UltiSnipsSnippetDirectories      = ["UltiSnips", "ultisnippets"]
let g:UltiSnipsEditSplit               = 'vertical'

