# Helper methods for prettier shell scripting - http://suderman.github.io/shelper
eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"

# Set path and environment variables
source ~/.env

# iTerm Shell Integration
source ~/.iterm2_shell_integration.zsh

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

# Enable null glob
setopt null_glob

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

# https://github.com/zeit/hyperterm/issues/186
export LANG="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# -----------------------------------------------------------------------------
# Plugins
# -----------------------------------------------------------------------------

# Prevent oh-my-zsh from messing with tmux windows
export DISABLE_AUTO_TITLE="true"

# https://github.com/nojhan/liquidprompt
(has ~/.liquidprompt) && [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# http://direnv.net
(has direnv) && eval "$(direnv hook $(shell))" 

# https://github.com/junegunn/fzf
has ~/.fzf.$(shell) && source ~/.fzf.$(shell)

# iTerm2
source if ~/.iterm2_shell_integration.zsh

# Completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

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
antigen bundle autojump 
antigen bundle nyan 
antigen bundle docker

# Tell antigen that you're done.
antigen apply


# -----------------------------------------------------------------------------
# ZSH Keybindings
# -----------------------------------------------------------------------------

# This binds Ctrl-g to rcd:
zle -N rcd
bindkey '^g' rcd


# -----------------------------------------------------------------------------
# Aliases & Functions
# -----------------------------------------------------------------------------

# python
alias server="python -m SimpleHTTPServer"

# nuc tmux
is osx && alias nuc="ssh nuc -t '~/.linuxbrew/bin/tmux a'"

# vi is vim
alias vi=vim

# memory hoggin' npm
alias npm8='node --max-old-space-size=8192 /usr/local/bin/npm'

# Add self-signed certificate
if has security; then
  alias trust="sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "
fi

# docker compose
alias dc='docker-compose'

# docker ip - get the ip address from a container
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# MySQL suffix shortcut
mysqls() {
  mysql --defaults-group-suffix=$1
}

# Kick a service to make sure it's running
if has ~/docker/bin/d; then
  kick() {
    has ~/docker/$1 && 
    defined $(cd ~/docker/$1 && ~/docker/bin/d info | grep stopped) && 
    cd ~/docker/$1 && ~/docker/bin/d refresh
  }
fi

# Wake MacPro and SSH in
macpro() {
  curl api.lan/den/macpro/wake
  sleep 1
  ssh macpro
}

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}

# Change directory using ranger
rcd() {
  tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
  ls -lah
}
