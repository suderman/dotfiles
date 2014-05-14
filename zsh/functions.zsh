# 2014 Jon Suderman
# https://github.com/suderman/local

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}

# Helper function for pretty messages
msg() { printf "\n\e[0;32m=> \e[0;37m$1\e[0m\n"; }
msg-install() { printf "\n\e[0;32m=> \e[0;37mInstalling \e[0;36m$1\e[0;37m...\e[0m\n"; }
msg-ask() { 
  if [ "$answer" == "y" ]; then msg-install $1;
  else
    printf "\n\e[0;32m=> \e[0;37mDo you want to install \e[0;36m$1\e[0;37m on this computer?\e[0m" 
    read -p " y/[n] " -n 1 -r; echo
    [[ $REPLY =~ ^[Yy]$ ]]
    if [ ! $? -ne 0 ]; then return 0; else return 1; fi
  fi
}

# Source from ~/.local or github
source-local() { 
  if [ $# -eq 1 ]; then
    eval "$(cat ~/.local/$1 || curl https://raw.githubusercontent.com/suderman/local/master/$1)" 
  fi
}

# source-local() {
#   if [ $# -eq 1 ]; then
#     [ -f $HOME/.local/$1 ] && source $HOME/.local/$1
#     [ -f $HOME/.local/$1 ] || source <(cat <(curl https://raw.githubusercontent.com/suderman/local/master/$1))
#   fi
# }

