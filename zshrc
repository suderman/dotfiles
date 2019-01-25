#!/usr/bin/env zsh

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="muse"

# Use hyphen-insensitive completion.
HYPHEN_INSENSITIVE="true"

# Disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(fzf git gitignore sudo rsync)

source $ZSH/oh-my-zsh.sh

# Path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
export PATH="./bin:~/bin:~/.dotfiles/bin:$PATH"

# Use Neovim as "preferred editor"
export EDITOR=nvim
export VISUAL=nvim
alias vim=nvim
alias vi=nvim

# True if command or file does exist
has() {
  if [ -e "$1" ]; then return 0; fi
  command -v $1 >/dev/null 2>&1 && { return 0; }
  return 1
}

# True if command or file doesn't exist
hasnt() {
  if [ -e "$1" ]; then return 1; fi
  command -v $1 >/dev/null 2>&1 && { return 1; }
  return 0
}

# True if variable is not empty
defined() {
  if [ -z "$1" ]; then return 1; fi  
  return 0
}

# True if variable is empty
undefined() {
  if [ -z "$1" ]; then return 0; fi
  return 1
}

# Source gracefully
source() {
  if [ -f "$1" ]; then
    builtin source "$1" && return 0;
  fi
}

# Local env
source ~/.env
