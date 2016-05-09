# 2015 Jon Suderman
# https://github.com/suderman/dotfiles

# Each bin listed in order it's checked

# Relative bin
MYPATH="bin"

# Home bin
(has ~/bin) && \
  MYPATH="$MYPATH:$HOME/bin"

# Vim bin
(has ~/.vim/bin) && \
  MYPATH="$MYPATH:$HOME/.vim/bin"

# linuxbrew
(has ~/.linuxbrew) && \
  MYPATH="$MYPATH:$HOME/.linuxbrew/bin"

# usr local bin (often Homebrew)
MYPATH="$MYPATH:/usr/local/bin:/usr/local/sbin"

# Docker bins
if has ~/docker; then
  MYPATH="$MYPATH:$HOME/docker/bin"
  if is zsh; then
    if undefined $({ ls $HOME/docker/*/bin } 2>&1); then
     for dockerbin in $HOME/docker/*/bin; do
       MYPATH="$MYPATH:$dockerbin"
     done
    fi
  fi
fi

# fzf
(has ~/.fzf)                         && \
  MYPATH="$MYPATH:$HOME/.fzf/bin"    && \
  MANPATH="$HOME/.fzf/man:$MANPATH"

# Heroku Toolbelt
(has /usr/local/heroku/bin) && \
  MYPATH="$MYPATH:/usr/local/heroku/bin"

# Append original path and strip duplicates
PATH="$MYPATH:$PATH"
export PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"

# Man path
export MANPATH="$HOME/local/share:/usr/local/man:$MANPATH"

# node_path
export NODE_PATH="/usr/local/lib/node_modules"
