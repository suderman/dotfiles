#!/bin/bash

# Ensure env directory exists
mkdir -p /config/env

# Write the env variable to disk if set; load from disk; set default if blank
# DOMAIN=getenv DOMAIN 'local'
# COUNTRY=getenv COUNTRY $(curl ipinfo.io/country)
getenv() {
  name=$1; 
  var=$(eval echo \$$name)
  [ -z "$var" ] || echo $var > /config/env/$name
  var=$(cat /config/env/$name)
  [ -z "$var" ] && var="$2" && echo $var > /config/env/$name
  echo $var
}

# Expand environment variables in files
# expenv DOMAIN /etc/ssl/openssl.cnf
expenv() {
  search=$1
  replace=$(eval echo \$$1)
  sed -i.bak "s/\$$search/$replace/g" $2
  rm $2.bak
}

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

# Source from file system or URL, fail gracefully
source() {

  # source if ~/path/to/file-if-exists.sh
  if [[ "$1" == "if" ]]; then 
    if [ -f "$2" ]; then 
      builtin source "$2" && return 0;
    fi

  # source ~/path/to/file-that-does-exist.sh
  elif [ -f "$1" ]; then
    builtin source "$1" && return 0;
  fi

  # url might be second argument if it's a remote fallback
  url="$1"; [ -n "$2" ] && url="$2" 

  # convert url to file path for caching
  file="$(__url-to-file "$url")"

  # source new www.example.com/always-new-download.sh
  [[ "$1" == "new" ]] && rm -f "$file" 

  # save url to local version if it doesn't exist
  [ -f "$file" ] || curl -s "$url" -o "$file"

  # source downloaded file
  [ -f "$file" ] && builtin source "$file" && return 0;

  return 1
}

__url-to-file() {
  localsrc="$HOME/.local/share/source"
  mkdir -p "$localsrc"
  echo "$localsrc/$(echo "$1" | sed \
      -e 's./.-SLASH-.g' \
      -e 's.:.-COLON-.g' \
      -e 's.|.-PIPE-.g')"
}


# Check shell type and OS
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

# Clever hacks to discover shell type
shell() {
  if [ -n "$version" ]; then echo "tcsh"
  elif [ -n "$BASH" ]; then echo "bash"
  elif [ -n "$ZSH_NAME" ]; then echo "zsh" 
  else echo "sh"
  fi
}

# Colors               Underline                       Background             Color Reset        
_black_='\e[0;30m';   _underline_black_='\e[4;30m';   _on_black_='\e[40m';   _reset_='\e[0m' 
_red_='\e[0;31m';     _underline_red_='\e[4;31m';     _on_red_='\e[41m';
_green_='\e[0;32m';   _underline_green_='\e[4;32m';   _on_green_='\e[42m';
_yellow_='\e[0;33m';  _underline_yellow_='\e[4;33m';  _on_yellow_='\e[43m';
_blue_='\e[0;34m';    _underline_blue_='\e[4;34m';    _on_blue_='\e[44m';
_purple_='\e[0;35m';  _underline_purple_='\e[4;35m';  _on_purple_='\e[45m';
_cyan_='\e[0;36m';    _underline_cyan_='\e[4;36m';    _on_cyan_='\e[46m';
_white_='\e[0;37m';   _underline_white_='\e[4;37m';   _on_white_='\e[47m';

# These can be overridden
export MSG_COLOR="$_white_"
export MSG_PROMPT="\n$_green_=> $_reset_"

# Pretty messages
msg() { printf "$MSG_PROMPT$MSG_COLOR$1$_reset_\n"; }

# Color functions
black()  { echo "$_black_$1$MSG_COLOR"; }
red()    { echo "$_red_$1$MSG_COLOR"; }
green()  { echo "$_green_$1$MSG_COLOR"; }
yellow() { echo "$_yellow_$1$MSG_COLOR"; }
blue()   { echo "$_blue_$1$MSG_COLOR"; }
purple() { echo "$_purple_$1$MSG_COLOR"; }
cyan()   { echo "$_cyan_$1$MSG_COLOR"; }
white()  { echo "$_white_$1$MSG_COLOR"; }

# If $answer is "y", then we don't bother with user input
ask() { 
  if [[ "$answer" == "y" ]]; then return 0; fi
  printf "$MSG_PROMPT$MSG_COLOR$1$_reset_";

  (is bash) && read -p " y/[n] " -n 1 -r
  (is zsh) && read -q "REPLY? y/[n] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
  if [ ! $? -ne 0 ]; then return 0; else return 1; fi
}
