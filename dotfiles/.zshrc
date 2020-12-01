# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

## TODO: try them out
# general options #
# unsetopt correctall 
# setopt extended_glob          # use global qualifiers in commands
# setopt no_beep                # no annoying beep on error
# setopt prompt_subst           # allow the use of parameters in the prompt (ex:'$PWD')
#
# # completion stuff
# setopt auto_menu                      # show completion menu on succesive tab press
# setopt always_to_end              # move cursor to end when completion
# setopt always_last_prompt     
# setopt auto_list          # list choices on any ambiguous completion
# setopt auto_name_dirs         # 
# setopt auto_param_slash           # add a trailing slash after name of a directory
# setopt auto_remove_slash
# setopt complete_aliases           # make alias a distinct command
# setopt list_packed            # make completion list smaller
#
# # directory stuff
# setopt auto_cd                # perform the cd command if command not found
# setopt cdable_vars
# setopt chase_links            # resolve symlink to its true values
#
#
# # history #
# setopt append_history         # on exit, append to history don't replace it
# setopt hist_reduce_blanks     # remove extra blanks before adding to history
# setopt hist_ignore_dups           # avoid duplicate lines in history
# setopt hist_verify                    # expand history onto the current line instead of executing it                      
# setopt share_history



# Path to your oh-my-zsh installation.
export ZSH="/home/marand/.oh-my-zsh"
ZSH_THEME="agnoster"


# === Plugins
#zsh-syntax-highlighting must be last
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval `dircolors ~/.dircolors`

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


### From Luke: https://www.youtube.com/watch?v=eLEo4OQ-cuQ

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
# HISTFILE=~/zsh_history
setopt INC_APPEND_HISTORY # adds to history instantly

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


# vim mode?
export EDITOR='vim'
# bindkey -v
# bindkey -v '^?' backward-delete-char
# export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# # Load aliases and shortcuts if existent.
# [ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/bin/aliases" ] && source "$HOME/bin/aliases"

bindkey '^ ' autosuggest-accept # bind autosuggestion accept to ctrl enter
bindkey "\e." insert-last-word # bash style cycle through last args. Works for alt-. as well. Great!

# Exports
export PATH="$HOME/.cargo/bin:$PATH"

alias sshconf='cat ~/.ssh/config'

alias cmd='cmd.exe'
alias gimp='cmd.exe /c "C:\Program Files\GIMP 2\bin\gimp-2.10.exe"'
alias node='node.exe'
alias npm='cmd.exe /c "C:\Program Files\nodejs\npm"'
alias tsc='cmd.exe /c tsc'
alias tldr='cmd.exe /c tldr'
alias rg='cmd.exe /c rg'

alias python='cmd.exe /c python'
alias pip='cmd.exe /c pip'
alias dotnet='cmd.exe /c dotnet'
alias java='cmd.exe /c java'
alias gradle='cmd.exe /c gradle'
alias gradlew='cmd.exe /c gradlew'

alias fav=vim ~/winhome/source/repos/marand-webpage/src/templates/favorites.html

