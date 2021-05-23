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


