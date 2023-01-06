# Some useful scripts and stuff

Hook up by moving git repo to ~/bin and hooking them up in .bashrc:

if [ -f ~/bin/aliases ]; then
    . ~/bin/aliases
fi
if [ -f ~/bin/git_aliases ]; then
    . ~/bin/git_aliases
fi

-----

Some scripts expect ~/winhome to exist (if on WSL)

create it with: ln -s /mnt/c/Users/CUR_USER ~/winhome

-----

hook up vim with: ln -s ~/bin/.vimrc ~
then download vundle with: git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
then install plugins in vim with :PluginInstall

-----

get dir colors: ln -s ~/bin/.dircolors ~

-----

A lot of scripts need fzf. I would recommend not installing fzf via a package manager. Instead go to fzf github, clone it, and run install script. Then things will get hooked up correctly to history, etc.
