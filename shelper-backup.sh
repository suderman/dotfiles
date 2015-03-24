#!/bin/bash

# 2014 Jon Suderman
# https://github.com/suderman/shelper

# Include this line at the top of your shell script:
# eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"


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

# Source from file system or URL
source-curl() { 
  if [ $# -eq 2 ]; then
    eval "$(cat $1 || curl $2)" 
  fi
}

# Source only if local file exists
source-existing() { 
  if [ $# -eq 1 ]; then
    if [ -f "$1" ]; then
      source $1
    fi
  fi
}

# Pretty messages
# msg() { printf "\n\e[0;32m=> \e[0;37m$1\e[0m\n"; }
msg() { printf "\n$_green_=> $_white_$1\n"; }

# Perhaps these are too specific and need to be generalized?
# msg-install() { printf "\n\e[0;32m=> \e[0;37mInstalling \e[0;36m$1\e[0;37m...\e[0m\n"; }
# msg-install() { msg "Installing $Cya$1$RCol..."; }

# If $answer is "y", then we don't bother with user input
ask() { 

  if is bash; then
    printf "\n$_green_=> $_white_$1$_reset_";
    read -p " y/[n] " -n 1 -r; echo
    [[ $REPLY =~ ^[Yy]$ ]]
    if [ ! $? -ne 0 ]; then return 0; else return 1; fi
  fi

}

is() {
  if [ $# -eq 1 ]; then
    [[ "$1" == "tcsh"   ]] && [[ "$(shell)" == "tcsh"  ]] && return 0
    [[ "$1" == "bash"   ]] && [[ "$(shell)" == "bash"  ]] && return 0
    [[ "$1" == "zsh"    ]] && [[ "$(shell)" == "zsh"   ]] && return 0
    [[ "$1" == "sh"     ]] && [[ "$(shell)" == "sh"    ]] && return 0
    [[ "$1" == "osx"    ]] && [[ "`uname`" == 'Darwin' ]] && return 0
    [[ "$1" == "ubuntu" ]] && [[ "`uname`" == 'Linux'  ]] && return 0
  fi
  return 1
}

shell() {
  if [ -n "$version" ]; then echo "tcsh"
  elif [ -n "$BASH" ]; then echo "bash"
  elif [ -n "$ZSH_NAME" ]; then echo "zsh" 
  else echo "sh"
  fi
}

# # If $answer is "y", then we don't bother with user input
# msg-ask() { 
#   if [ "$answer" == "y" ]; then msg-install $1;
#   else
#     printf "\n\e[0;32m=> \e[0;37mDo you want to install \e[0;36m$1\e[0;37m on this computer?\e[0m" 
#     read -p " y/[n] " -n 1 -r; echo
#     [[ $REPLY =~ ^[Yy]$ ]]
#     if [ ! $? -ne 0 ]; then return 0; else return 1; fi
#   fi
# }

# Regular             Underline                       Background             Color Reset        
_black_='\e[0;30m';   _underline_black_='\e[4;30m';   _on_black_='\e[40m';   _reset_='\e[0m' 
_red_='\e[0;31m';     _underline_red_='\e[4;31m';     _on_red_='\e[41m';
_green_='\e[0;32m';   _underline_green_='\e[4;32m';   _on_green_='\e[42m';
_yellow_='\e[0;33m';  _underline_yellow_='\e[4;33m';  _on_yellow_='\e[43m';
_blue_='\e[0;34m';    _underline_blue_='\e[4;34m';    _on_blue_='\e[44m';
_purple_='\e[0;35m';  _underline_purple_='\e[4;35m';  _on_purple_='\e[45m';
_cyan_='\e[0;36m';    _underline_cyan_='\e[4;36m';    _on_cyan_='\e[46m';
_white_='\e[0;37m';   _underline_white_='\e[4;37m';   _on_white_='\e[47m';

# Reload from Github
shelper() {
  rm -rf "$HOME/.local/share/shelper.sh"
  eval "$(cat ~/.local/share/shelper.sh || curl shelper.suderman.io/shelper.sh)"
}

# Install a local copy of this script
if hasnt "$HOME/.local/share/shelper.sh"; then
  mkdir -p $HOME/.local/share
  curl -sS "shelper.suderman.io/shelper.sh" -o "$HOME/.local/share/shelper.sh"
fi

