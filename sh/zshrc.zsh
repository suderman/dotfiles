# Helper methods for prettier shell scripting - http://suderman.github.io/shelper
eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"

# Enable null glob
setopt null_glob

# Prevent oh-my-zsh from messing with tmux windows
export DISABLE_AUTO_TITLE="true"

# Load bundles with antigen
source ~/.antigen/antigen.zsh

# Bundles
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# OMZ bundles
antigen use oh-my-zsh

antigen bundle osx 
antigen bundle git
antigen bundle heroku
antigen bundle brew 
antigen bundle brew-cask 
# antigen bundle tmux 
antigen bundle autojump 
antigen bundle nyan 
antigen bundle docker
# antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

# Tell antigen that you're done.
antigen apply

#------------------
# ZSH Configuration
#------------------
source ~/.sh/path.sh
source ~/.sh/env.sh
source ~/.sh/aliases.sh
source ~/.sh/functions.sh

# vi mode
bindkey -v
bindkey -M vicmd v edit-command-line
KEYTIMEOUT=1

# Disable autocorrect
unsetopt correct_all

# umask permissions
umask 0002

# Allow use of CTRL-S and CTRL-Q
setopt NO_FLOW_CONTROL
stty -ixon

# Enable SSH agent forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on

# http://direnv.net
(has direnv) && eval "$(direnv hook $(shell))" 

# https://github.com/junegunn/fzf
has ~/.fzf.$(shell) && source ~/.fzf.$(shell)

# https://github.com/nojhan/liquidprompt
(has ~/.liquidprompt) && [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# iTerm2
source if ~/.iterm2_shell_integration.zsh

# Completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

#------------------
# ZSH Keybindings
#------------------

# This binds Ctrl-g to rcd:
zle -N rcd
bindkey '^g' rcd

