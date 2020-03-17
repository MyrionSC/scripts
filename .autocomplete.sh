#!/usr/bin/env bash

# bash completion file

# docs
_docs_completion='$(ls ~/bin/documentation)'
complete -W "${_docs_completion}" 'docs'

# vars
_var_completion='$(ls ~/bin/variables)'
complete -W "${_var_completion}" 'var'

#gclm
_gclm_completion='$(~/bin/gclm)'
complete -W "${_gclm_completion}" 'gclm'

#gbdl
_gbdl_completion='$(git branch)'
complete -W "${_gbdl_completion}" 'gbdl'

#viewlog
_viewlogs_completion='$(ls ~/logs)'
complete -W "${_viewlogs_completion}" 'viewlog'

# mardl (note: only gets what was in marand:/var/www/html/share when opening shell)
#_mardl_completion=$(ssh marand@marand.dk "ls -tA /var/www/html/share")
#complete -W "${_mardl_completion}" 'mardl'

# to add have normal bash options as well:
#complete -W "${options}" -o bashdefault -o default 'scriptname'

### more inteligent completion (could not make this work)
#_script()
#{
#  #_script_commands=$(/path/to/your/script.sh shortlist)
#  _script_commands=$(ls ~/bin/documentation)
#  echo $_script_commands
#
#  local cur
#  COMPREPLY=()
#  cur="${COMP_WORDS[COMP_CWORD]}"
#  echo $cur
#  COMPREPLY=( $(compgen -W "haha") )
#
#  return 0
#}
#complete -o nospace -F _script ~/bin/docs.sh
