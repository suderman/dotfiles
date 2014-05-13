# 2014 Jon Suderman
# https://github.com/suderman/local

# Each bin listed in order it's checked

# Relative bin
MYPATH="bin"

# Home bin
if [ -d $HOME/bin ]; then
  MYPATH="$MYPATH:$HOME/bin"
fi

# Local bin for OS X
if [ $PLATFORM = "osx" ]; then
  MYPATH="$MYPATH:$HOME/.local/osx/bin"
fi

# Local bin for Ubuntu
if [ $PLATFORM = "ubuntu" ]; then
  MYPATH="$MYPATH:$HOME/.local/ubuntu/bin"
fi

# Local bin
if [ -d $HOME/.local/bin ]; then
  MYPATH="$MYPATH:$HOME/.local/bin"
fi

# Vim bin
if [ -d $HOME/.vim/bin ]; then
  MYPATH="$MYPATH:$HOME/.vim/bin"
fi

# linuxbrew
if [ -d ~/.linuxbrew ]; then
  MYPATH="$MYPATH:$HOME/.linuxbrew/bin"
  export LD_LIBRARY_PATH="$HOME/.linuxbrew/lib:$LD_LIBRARY_PATH"
fi

# usr local bin (often Homebrew)
MYPATH="$MYPATH:/usr/local/bin:/usr/local/sbin"

# tmuxifier
if [ -d ~/.tmuxifier ]; then
  MYPATH="$MYPATH:$HOME/.tmuxifier/bin"
fi

# Heroku Toolbelt
if [ -d /usr/local/heroku/bin ]; then
  MYPATH="$MYPATH:/usr/local/heroku/bin"
fi

# Append original path and strip duplicates
PATH="$MYPATH:$PATH"
export PATH="$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')"

# Man path
export MANPATH="$HOME/local/share:/usr/local/man:$MANPATH"

