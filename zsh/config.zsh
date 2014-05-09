# 2014 Jon Suderman
# https://github.com/suderman/local

#------------------
# ZSH Configuration
#------------------

# vi mode
bindkey -v
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

