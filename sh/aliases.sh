# 2014 Jon Suderman
# https://github.com/suderman/local

# Make these commands ask before clobbering a file
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Use human-readable filesizes
alias du="du -h"
alias df="df -h"

# Quick access to dotfiles
alias dotfiles='cd $HOME/.local/dotfiles; ls -lh'

# bundler laziness
if has bundle; then
  alias be="bundle exec"
  alias bi="bundle install --path vendor/bundle"
  alias bb="bundle install --binstubs"
  alias bl="bundle list"
  alias bs="bundle show"
  alias bu="bundle update"
  alias bp="bundle package"
fi

# python
alias server="python -m SimpleHTTPServer"
