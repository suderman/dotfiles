# Helper methods for prettier shell scripting - http://suderman.github.io/shelper
eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"

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
source ~/.local/sh/path.sh
source ~/.local/sh/env.sh
source ~/.local/sh/aliases.sh
source ~/.local/sh/functions.sh

# http://direnv.net
(has direnv) && eval "$(direnv hook $(shell))" 

# https://github.com/junegunn/fzf
has ~/.fzf.$(shell) && source ~/.fzf.$(shell)

# https://github.com/nojhan/liquidprompt
(has ~/.liquidprompt) && [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt
