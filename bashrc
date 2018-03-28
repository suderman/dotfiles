# Helper methods for prettier shell scripting - http://suderman.github.io/shelper
eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"

# Set path and environment variables
source ~/.env

# iTerm Shell Integration
# source ~/.iterm2_shell_integration.bash

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

# Enable null glob
shopt -s nullglob

# Vi mode
set -o vi
KEYTIMEOUT=0

# umask permissions
umask 0002

# no need to cd
# shopt -s autocd


# -----------------------------------------------------------------------------
# Plugins
# -----------------------------------------------------------------------------

# https://github.com/Bash-it/bash-it
export BASH_IT="$HOME/.bash_it"
(has $BASH_IT) && source $BASH_IT/bash_it.sh

# https://github.com/nojhan/liquidprompt
(has ~/.liquidprompt) && [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# http://direnv.net
(has direnv) && eval "$(direnv hook $(shell))" 

# https://github.com/junegunn/fzf
has ~/.fzf.$(shell) && source ~/.fzf.$(shell)


# -----------------------------------------------------------------------------
# Aliases & Functions
# -----------------------------------------------------------------------------

# python
alias server="python -m SimpleHTTPServer"

# nuc tmux
is osx && alias nuc="ssh nuc -t '~/.linuxbrew/bin/tmux a'"

# Add all keys to ssh-agent
# is osx && ssh-add -A

# Quickly determine what is keeping mac awake
if has pmset; then
  alias sleepless="pmset -g assertions | egrep '(PreventUserIdleSystemSleep|PreventUserIdleDisplaySleep)'"
fi

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

alias cdm='cd /Volumes/Media'
alias cdf='cd /Volumes/Family'

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

# # Wake MacPro and SSH in
# macpro() {
#   curl api.lan/den/macpro/wake
#   sleep 1
#   ssh macpro
# }

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

if [ -f $(brew --prefix)/etc/bash_completion ]; then source $(brew --prefix)/etc/bash_completion; fi