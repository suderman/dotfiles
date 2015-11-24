# Helper methods for prettier shell scripting - http://suderman.github.io/shelper
eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"

# Enable null glob
shopt -s nullglob

# Vi mode
set -o vi
KEYTIMEOUT=0

# umask permissions
umask 0002

# https://github.com/Bash-it/bash-it
export BASH_IT="$HOME/.bash_it"
unset MAILCHECK
(has $BASH_IT) && source $BASH_IT/bash_it.sh

# Use what I can
source ~/.sh/path.sh
source ~/.sh/env.sh
source ~/.sh/aliases.sh
source ~/.sh/functions.sh

# http://direnv.net
(has direnv) && eval "$(direnv hook $(shell))" 

# https://github.com/junegunn/fzf
has ~/.fzf.$(shell) && source ~/.fzf.$(shell)

# https://github.com/nojhan/liquidprompt
(has ~/.liquidprompt) && [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt
