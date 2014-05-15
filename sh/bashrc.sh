# Sometimes scripts call bash instead of my beloved zsh
# ...so I have to maintain a little bashrc too I guess

# Helper methods for prettier shell scripting - http://shelper.suderman.io
eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"

# Use what I can
source ~/.local/sh/path.sh
source ~/.local/sh/env.sh
source ~/.local/sh/aliases.sh
source ~/.local/sh/functions.sh

# http://direnv.net
(has direnv) && eval "$(direnv hook bash)" 

# umask permissions
umask 0002

