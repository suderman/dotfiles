cite about-plugin
about-plugin 'custom plugin'

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------
# Local bin directories
path_prepend ./bin ~/bin ~/.dotfiles/bin ~/Support/Bin

# Homebrew bin directories
path_append /usr/local/bin /usr/local/sbin /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin
 
# Python bin directories
path_append ~/Library/Python/2.7/bin ~/Library/Python/3.6/bin  

# -----------------------------------------------------------------------------
# launchd
# -----------------------------------------------------------------------------
(has launchup) && export LAUNCHD_PLISTS="~/.launchd"

# -----------------------------------------------------------------------------
# ASDF
# -----------------------------------------------------------------------------
(has ~/.asdf) && source ~/.asdf/asdf.sh

# -----------------------------------------------------------------------------
# FZF
# https://github.com/junegunn/fzf
# -----------------------------------------------------------------------------
if (has fzf); then
  (has rg) && export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
  (has rg) && export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {} || coderay {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'"
  export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
  #export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"  
  (has bfs) && export FZF_ALT_C_COMMAND="bfs -type d -nohidden"  
  (has tree) && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
fi