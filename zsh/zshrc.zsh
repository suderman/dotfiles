source $HOME/.antigen/antigen.zsh

# Helper methods for prettier shell scripting - http://shelper.suderman.io
eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"

# Determine if this is OS X or Ubuntu
source $HOME/.local/zsh/platform.zsh

# Local bundles
(has fzf) && antigen bundle $HOME/.local/zsh/bundles/fzf
# antigen bundle $HOME/.local/zsh/bundles/vi-visual
# source $HOME/.local/zsh/bundles/opp/opp.plugin.zsh

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

# My configuration
source $HOME/.local/zsh/path.zsh
source $HOME/.local/zsh/env.zsh
source $HOME/.local/zsh/config.zsh
source $HOME/.local/zsh/aliases.zsh
source $HOME/.local/zsh/functions.zsh

