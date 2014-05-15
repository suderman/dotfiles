# 2014 Jon Suderman
# https://github.com/suderman/local

# Each bin listed in order it's checked

# Relative bin
MYPATH="bin"

# Home bin
(has ~/bin) && \
  MYPATH="$MYPATH:$HOME/bin"

# Local bin for OS X
(is osx) && \
  MYPATH="$MYPATH:$HOME/.local/osx/bin"

# Local bin for Ubuntu
(is ubuntu) && \
  MYPATH="$MYPATH:$HOME/.local/ubuntu/bin"

# Local bin
(has ~/.local/bin) && \
  MYPATH="$MYPATH:$HOME/.local/bin"

# Vim bin
(has ~/.vim/bin) && \
  MYPATH="$MYPATH:$HOME/.vim/bin"

# linuxbrew
if has ~/.linuxbrew; then
  MYPATH="$MYPATH:$HOME/.linuxbrew/bin"
  export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
fi

# usr local bin (often Homebrew)
MYPATH="$MYPATH:/usr/local/bin:/usr/local/sbin"

# tmuxifier
(has ~/.tmuxifier) && \
  MYPATH="$MYPATH:$HOME/.tmuxifier/bin"

# Heroku Toolbelt
(has /usr/local/heroku/bin) && \
  MYPATH="$MYPATH:/usr/local/heroku/bin"

# Append original path and strip duplicates
PATH="$MYPATH:$PATH"
export PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"

# Man path
export MANPATH="$HOME/local/share:/usr/local/man:$MANPATH"

