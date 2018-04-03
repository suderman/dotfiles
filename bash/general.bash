#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# Aliases & Functions
# -----------------------------------------------------------------------------

# Refresh rcm symlinks
alias rcm="rcdn && ln -sf ~/.dotfiles/rcrc ~/.rcrc && rcup"

# python
alias server="python -m SimpleHTTPServer"

# Quickly determine what is keeping mac awake
if has pmset; then
  alias sleepless="pmset -g assertions | egrep '(PreventUserIdleSystemSleep|PreventUserIdleDisplaySleep)'"
fi

if is macos; then
  alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}

dotfiles-update() {
  cd ~/.dotfiles && git pull
  bash-it update    
  $(brew --prefix)/bin/gem update
  vim-update-bundles
  brew update && brew upgrade
}
