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

# True if command or file doesn't exist
hasnt() {
  if [ -e "$1" ]; then return 1; fi
  command -v $1 >/dev/null 2>&1 && { return 1; }
  return 0
}

# True if variable is not empty
defined() {
  if [ -z "$1" ]; then return 1; fi  
  return 0
}

# True if variable is empty
undefined() {
  if [ -z "$1" ]; then return 0; fi
  return 1
}

# Source from file system or URL, fail gracefully
source() {

  # source ~/path/to/file-that-does-exist.sh
  if [ -f "$1" ]; then
    builtin source "$1" && return 0;
  fi

  # url might be second argument if it's a remote fallback
  local url="$1"; [ -n "$2" ] && url="$2" 

  # convert url to file path for caching
  local file="$(__url-to-file "$url")"

  # source new www.example.com/always-new-download.sh
  [[ "$1" == "new" ]] && rm -f "$file" 

  # save url to local version if it doesn't exist
  [ -f "$file" ] || curl -s "$url" -o "$file"

  # source downloaded file
  [ -f "$file" ] && builtin source "$file" && return 0;

  return 1
}

__url-to-file() {
  local localsrc="$HOME/.local/share/source"
  mkdir -p "$localsrc"
  echo "$localsrc/$(echo "$1" | sed \
      -e 's./.-SLASH-.g' \
      -e 's.:.-COLON-.g' \
      -e 's.|.-PIPE-.g')"
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
export MSG_PROMPT="$_green_=> $_reset_"

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
  printf "1";

  (is bash) && read -p " y/[n] " -n 1 -r
  (is zsh) && read -q "REPLY? y/[n] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]]
  if [ ! $? -ne 0 ]; then return 0; else return 1; fi
}

# Usage: echo $(escape "$1")
escape() {
  echo "$@" | sed 's/\([^a-zA-Z0-9_]\)/\\\1/g'
}

# Save a variable to disk, using existing or default
ref() {
  if [ $# -lt 1 ]; then
    msg 'Usage: VARIABLE=$(ref VARIABLE defaultvalue)'
  else

    # Ensure ~/.ref exists and define store
    local store=$HOME/.ref/$1
    mkdir -p $HOME/.ref && touch $store

    # Attempt to get value from variable
    local value=$(eval echo \$$1)

    # If value successfully set, save it to store
    [ -z "$value" ] || echo $value > $store

    # Attempt to get value from store
    value=$(cat $store)

    # If value is still unset, use default and save that to store
    if [ ! -z "$2" ]; then
      [ -z "$value" ] && value="$2" && echo $value > $store
    fi

    # Return value
    echo $value
  fi
}

# Dereference (expand) $VARIABLES in a file and write to disk
deref() {
  if [ ! -r "$1" ]; then
    msg "Usage: deref /path/to/file"
  else $(
    # Loop all environment variable lines
    for line in $(printenv); do
      # Get variable name
      search="$( cut -d '=' -f 1 <<< "$line" )";
      # Look only for UPPERCASE variables
      if [ $(echo $search | grep "^[A-Z]") ]; then
        # Get value of UPPERCASE variable
        replace=$(eval echo \$$search)
        # Replace all $UPPERCASE names with values (skips values with = character)
        if (is osx); then
          [[ $replace == *"="* ]] || sed -i '' "s=\$$search=$replace=g" $1
        else
          [[ $replace == *"="* ]] || sed -i    "s=\$$search=$replace=g" $1
        fi
      fi
    done
  );fi
}

# Note: Search/Replace
# sed -i s/SEARCH/REPLACE/g file.txt

# Append line to end of file if it doesn't exist
append() {
  if [ $# -lt 2 ] || [ ! -r "$2" ]; then
    msg 'Usage: append "line to append" /path/to/file'
  else
    grep -q "^$1" $2 || echo "$1" >> $2
  fi
}

# Copy from file system or URL, fail gracefully
copy() {
  if [ $# -lt 2 ]; then
    msg 'Usage: copy source destination'
  else

    # Expand paths
    local src=$(echo "$1")
    local dest=$(echo "$2")

    # Ensure destination directory exists
    mkdir -p "$(dirname $dest)"

    # Save backup of destination if it exists
    [ -e "$dest" ] && mv "$dest" "$dest.bak"

    # copy ~/path/to/existing-file.txt ~/path/to/destination.txt
    if [ -e "$src" ]; then 
      cp -rf "$src" "$dest";
    else

      # Attempt to download 
      rm -rf "$dest.curl"
      curl "$src" -so "$dest.curl"

      # copy www.good-domain.com/real-file.txt ~/path/to/destination.txt
      if [ -s "$dest.curl" ]; then
        mv "$dest.curl" "$dest"

      # copy www.bad-domain.com/bad-file.txt ~/path/to/destination.txt
      elif [ -f "$dest.bak" ]; then
        rm -rf "$dest.curl" 
        mv "$dest.bak" "$dest"
      fi
    fi
  fi
}

# Run a command as a specific user
runas() {
  if [ $# -lt 2 ]; then
    msg 'Usage: runas user command'
  else
    sudo -H -u $1 bash -c "${@:2}"
  fi
}

# Remove leading/trailing whitespace
trim() {
  echo "$*" | sed 's/^ *//g' | sed 's/ *$//g'
}

# Shared function for keyval, key, val
__lookup() {
  echo $(
    lookup=""; count=0; all=()
    for pair in $(echo $3 | tr ',' ' '); do
      let count=count+1
      key=${pair%%:*}
      val=${pair##*:}
      if [[ $1 == keyval ]]; then
        all[count]=$pair
        [[ "$key" == "$2" ]] && lookup="$pair"
      elif [[ $1 == key ]]; then
        all[count]=$key
        [[ "$val" == "$2" ]] && lookup="$key"
      elif [[ $1 == val ]]; then
        all[count]=$val
        [[ "$key" == "$2" ]] && lookup="$val"
      fi
    done
    if [[ $2 == :* ]]; then
      if [[ $2 == :all ]]; then 
        lookup=${all[*]}
      else
        index=${2##*:}
        [[ $2 == :first ]] && index=1
        [[ $2 == :last ]]  && index=$count
        lookup="${all[$index]}"
      fi
    fi
  echo $lookup)
}

# Lookup keyval pair by key or position
keyval() {
  if [ $# -lt 2 ]; then
    msg 'Usage: keyval (KEY|:POSITION) key:value,key2:value2,lastkey:lastval'
  else
    __lookup keyval $1 $2
  fi
}

# Lookup key by val or position
key() {
  if [ $# -lt 2 ]; then
    msg 'Usage: key (VAL|:POSITION) key:value,key2:value2,lastkey:lastval'
  else
    __lookup key $1 $2
  fi
}

# Lookup val by key or position
val() {
  if [ $# -lt 2 ]; then
    msg 'Usage: val (KEY|:POSITION) key:value,key2:value2,lastkey:lastval'
  else
    __lookup val $1 $2
  fi
}

# Make a script wait for host to be ready
waitfor() {
  if [ $# -lt 1 ]; then
    msg 'Usage: waitfor host [cert/key basename]'
  else
    local host=${1%%:*}
    local port=${1##*:}
    [[ $host == $port ]] && port=80

    if [[ "$port" == "3306" ]]; then
      local command="mysql"
      local certs=""
      defined "$2" && certs="--ssl-cert=${2}.crt --ssl-key=${2}.key"
      local check="defined \$(mysql -h $host -P $port $certs -e 'show databases;' 2>null)"
    else
      local command="curl"
      local check="curl -fso /dev/null ${host}:${port}"
    fi

    if has $command; then
      if ! $(eval $check); then
        printf "${MSG_PROMPT}${MSG_COLOR}Waiting for ${host}:${port} to become available.";
        sleep 2
        until $(eval $check); do
          printf "."
          sleep 2
        done
        printf "$_reset_\n"; 
      fi
    fi
  fi
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
