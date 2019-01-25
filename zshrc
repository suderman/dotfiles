#!/usr/bin/env zsh
for f in ~/.dotfiles/zsh/*.zsh; do 
  [[ -f "$f" ]] && source "$f"; 
done
