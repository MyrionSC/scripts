#!/usr/bin/env bash

DATAFILES=~/bin/datafiles
vim +'redir! > ~/bin/datafiles/cmds | sil com' +q && cut -b5- $DATAFILES/cmds | cut -d ' ' -f 1 > $DATAFILES/all-vim-commands.txt
rm $DATAFILES/cmds

