# Some useful scripts and stuff

Hook up by moving git repo to ~/bin and hooking them up in .bashrc:

```
if [ -f ~/bin/aliases ]; then
    . ~/bin/aliases
fi

if [ -f ~/bin/git_aliases ]; then
    . ~/bin/git_aliases
fi
```

-----

hook up vim with: 

```
ln -s ~/bin/.vimrc ~
```

then download vundle with: 

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

then install plugins in vim with :PluginInstall

to get vim clipboard on ubuntu (kubuntu, mint)

```
sudo apt-get install vim-gtk3 -y
```

then restart shell

-----

ide config:

```
ln -s /home/martinra/bin/config/ide-config/jetbrains/.ideavimrc ~
```

-----

z fast manager


```
mkdir -p ~/.local/bin
(cd ~/.local/bin && wget https://raw.githubusercontent.com/rupa/z/refs/heads/master/z.sh && chmod u+x z.sh)
echo . ~/.local/bin/z.sh >> .bashrc
```

cd around a little and use zz to jump

-----

terminal: download ghostty from packet manager if possible, then:

```
ln -s /home/martinra/bin/config/ghostty /home/martinra/.config/ghostty
```

-----

```
ln -s /home/martinra/bin/config/ghostty /home/martinra/.config/ghostty
```

-----


Some scripts expect ~/winhome to exist (if on WSL)

create it with: ln -s /mnt/c/Users/CUR_USER ~/winhome


-----

get dir colors: ln -s ~/bin/.dircolors ~

-----

A lot of scripts need fzf. I would recommend not installing fzf via a package manager. Instead go to fzf github, clone it, and run install script. Then things will get hooked up correctly to history, etc.

https://github.com/junegunn/fzf

---






