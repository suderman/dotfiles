#!/usr/bin/env zsh

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------

# Homebrew bin directories
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Linuxbrew bin directories
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

# Local bin directories
export PATH="./bin:~/bin:~/.dotfiles/bin:$PATH"


# -----------------------------------------------------------------------------
# CONFIG
# -----------------------------------------------------------------------------

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Use Neovim as "preferred editor"
export EDITOR=nvim
export VISUAL=nvim

export LSCOLORS=cxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Local env
source ~/.env
