# Helper methods for prettier shell scripting - http://shelper.suderman.io
eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"

source ~/.antigen/antigen.zsh

# Local bundles
(has fzf) && antigen bundle ~/.local/sh/bundles/fzf
# antigen bundle ~/.local/sh/bundles/vi-visual
# source ~/.local/sh/bundles/opp/opp.plugin.zsh

# Other bundles
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# OMZ bundles
antigen use oh-my-zsh

antigen bundle osx 
antigen bundle git
antigen bundle heroku
antigen bundle colored-man
antigen bundle brew 
antigen bundle brew-cask 
antigen bundle tmux 
antigen bundle autojump 
antigen bundle nyan 
antigen bundle docker
# antigen bundle npm 
# antigen bundle chruby 
# antigen bundle gem 
# antigen bundle rails 
# antigen bundle pip
# antigen bundle command-not-found
# antigen bundle extract 

# Load the theme.
# antigen theme flazz
antigen theme fwalch

# Tell antigen that you're done.
antigen apply

#------------------
# ZSH Configuration
#------------------
source ~/.local/sh/path.sh
source ~/.local/sh/env.sh
source ~/.local/sh/aliases.sh
source ~/.local/sh/functions.sh

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
(has direnv) && eval "$(direnv hook zsh)" 

#------------------
# ZSH Keybindings
#------------------

# This binds Ctrl-O to ranger-cd:
zle -N ranger-cd
bindkey '^o' ranger-cd

