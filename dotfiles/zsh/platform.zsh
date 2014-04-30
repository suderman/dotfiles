# 2014 Jon Suderman
# https://github.com/suderman/local

# Figure out what we're dealing with
PLATFORM='unknown'
uname_string=`uname`

# OS X
if [[ "$uname_string" == 'Darwin' ]]; then
   PLATFORM='osx'

# Ubuntu
elif [[ "$uname_string" == 'Linux' ]]; then
   PLATFORM='ubuntu'
fi

export PLATFORM
