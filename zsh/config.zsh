# 2014 Jon Suderman
# https://github.com/suderman/local

#------------------
# ZSH Configuration
#------------------

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

# Change directory using ranger
function ranger-cd() {
  tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
  ls -lah
}
ranger-cd-wrapper() {
  ranger-cd
  ls -lah
}

# This binds Ctrl-O to ranger-cd:
zle -N ranger-cd
bindkey '^o' ranger-cd

