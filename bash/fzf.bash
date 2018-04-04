#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# FZF
# https://github.com/junegunn/fzf
# bash-it enable plugin fzf
# -----------------------------------------------------------------------------
if (has fzf); then
  
  (has rg) && export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
  (has rg) && export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {} || coderay {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'"
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
  #export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"  
  (has bfs) && export FZF_ALT_C_COMMAND="bfs -type d -nohidden"  
  (has tree) && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

  # Add some FZF completions
  complete -o default -F _fzf_path_completion l
  complete -o default -F _fzf_path_completion la
  complete -o nospace -F _fzf_dir_completion z

fi

# Ctrl-F to find frecent (frequent/recent) directories
if (has fzf) && (has fasd_cd); then
  frecent(){
    cd "$(fasd_cd -d -l | fzf --preview 'tree -C {} | head -200')"
  }
  bind '"\C-f": " \C-e\C-ufrecent\n"'
fi

# Ctrl-G to go to folder under current working directory
if (has fzf) && (has bfs); then
  go(){
    cd "$(bfs -type d -nohidden -f "$(pwd)" 2>/dev/null | fzf --preview 'tree -C {} | head -200')"
  }
  bind '"\C-g": " \C-e\C-ugo\n"'
fi
