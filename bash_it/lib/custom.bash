#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# HELPERS
# -----------------------------------------------------------------------------

# True if command or file does exist
has() {
  if [ -e "$1" ]; then return 0; fi
  command -v $1 >/dev/null 2>&1 && { return 0; }
  return 1
}

# True if variable is not empty
defined() {
  if [ -z "$1" ]; then return 1; fi  
  return 0
}

# Clever hacks to discover shell type
shell() {
  if [ -n "$version" ]; then echo "tcsh"
  elif [ -n "$BASH" ]; then echo "bash"
  elif [ -n "$ZSH_NAME" ]; then echo "zsh" 
  else echo "sh"
  fi
}

# Check shell type and OS
is() {
  if [ $# -eq 1 ]; then
    [[ "$1" == "tcsh"   ]] && [[ "$(shell)" == "tcsh"  ]] && return 0
    [[ "$1" == "bash"   ]] && [[ "$(shell)" == "bash"  ]] && return 0
    [[ "$1" == "zsh"    ]] && [[ "$(shell)" == "zsh"   ]] && return 0
    [[ "$1" == "sh"     ]] && [[ "$(shell)" == "sh"    ]] && return 0
    [[ "$1" == "macos"  ]] && [[ "`uname`" == 'Darwin' ]] && return 0
    [[ "$1" == "linux"  ]] && [[ "`uname`" == 'Linux'  ]] && return 0
  fi
  return 1
}

# If $answer is "y", then we don't bother with user input
ask() { 
  if [[ "$answer" == "y" ]]; then return 0; fi
  printf "1";

  (is bash) && read -p " y/[n] " -n 1 -r
  (is zsh) && read -q "REPLY? y/[n] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
  if [ ! $? -ne 0 ]; then return 0; else return 1; fi
}

path_append() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
  #PATH=$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')
}

path_prepend() {
  for ((i=$#; i>0; i--)); 
  do
    ARG=${!i}
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
  #PATH=$(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')
}