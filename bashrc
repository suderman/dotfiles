# Helper methods for prettier shell scripting - http://suderman.github.io/shelper
eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"

# Set path and environment variables
source ~/.env

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

shopt -s nullglob
umask 002

# -----------------------------------------------------------------------------
# Plugins
# -----------------------------------------------------------------------------

# https://github.com/Bash-it/bash-it
#export BASH_IT="$HOME/.bash_it"
#(has $BASH_IT) && source $BASH_IT/bash_it.sh

## https://github.com/nojhan/liquidprompt
#(has ~/.liquidprompt) && [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# http://direnv.net
(has direnv) && eval "$(direnv hook $(shell))" 

# https://github.com/junegunn/fzf
has ~/.fzf.$(shell) && source ~/.fzf.$(shell)

export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {} || coderay {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# -----------------------------------------------------------------------------
# Aliases & Functions
# -----------------------------------------------------------------------------

# python
alias server="python -m SimpleHTTPServer"

# Quickly determine what is keeping mac awake
if has pmset; then
  alias sleepless="pmset -g assertions | egrep '(PreventUserIdleSystemSleep|PreventUserIdleDisplaySleep)'"
fi

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}

if [ -f $(brew --prefix)/etc/bash_completion ]; then source $(brew --prefix)/etc/bash_completion; fi
