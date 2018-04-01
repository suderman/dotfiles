# 2018 Jon Suderman
# https://github.com/suderman/dotfiles

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

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------

# Each bin listed in order it's checked
setpath() {

  # default path
  local DEFAULT_PATH=$PATH

  # relative bin
  local PATH="bin"

  # home bin
  (has ~/bin) && PATH="$PATH:$HOME/bin"

  # Support bin
  (has ~/Support/Bin) && PATH="$PATH:$HOME/Support/Bin"

  # rbenv bin
  #(has ~/.rbenv/shims) && PATH="$PATH:$HOME/.rbenv/shims"
  #(has ~/.rbenv/bin) && PATH="$PATH:$HOME/.rbenv/bin"

  # python bin
  (has ~/Library/Python/2.7/bin) && PATH="$PATH:$HOME/Library/Python/2.7/bin"
  (has ~/Library/Python/3.6/bin) && PATH="$PATH:$HOME/Library/Python/3.6/bin"

  # linuxbrew bin
  (has ~/.linuxbrew) && PATH="$PATH:$HOME/.linuxbrew/bin" 

  # homebrew bin 
  PATH="$PATH:/usr/local/bin:/usr/local/sbin"

  # default PATH
  PATH="$PATH:$DEFAULT_PATH"

  # strip duplicates
  echo $(printf "%s" "${PATH}" | /usr/bin/awk -v RS=: -v ORS=: '!($0 in a) {a[$0]; print}')
}

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}

# Set PATH variable
export PATH=$(setpath)


# -----------------------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------------------

# Some of these settings will look here
BREW_PREFIX="/usr/local"
(has brew) && BREW_PREFIX="$(brew --prefix)"
source $BREW_PREFIX/etc/bash_completion

# Manually set your language environment
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# use vim as an editor
export EDITOR=vim
export VISUAL=vim

# launchd
(is macos) && export LAUNCHD_PLISTS="~/.launchd"

# ~/.config
export XDG_CONFIG_HOME="$HOME/.config"

## chruby
#source $BREW_PREFIX/share/chruby/chruby.sh
#source $BREW_PREFIX/share/chruby/auto.sh

## rbenv
#(has rbenv) && eval "$(rbenv init -)"


# -----------------------------------------------------------------------------
# NeoVim
# -----------------------------------------------------------------------------
if has nvim; then  

  # Use Neovim as "preferred editor"
  export EDITOR=nvim
  export VISUAL=nvim

  # Use Neovim instead of Vim or Vi
  alias vim=nvim
  alias vi=nvim

  # Check if inside a nvim session
  if defined "$NVIM_LISTEN_ADDRESS"; then

    # disallow nesting of nvims within nvims
    (has nvr) && alias nvim=nvr
    (has nvr) || alias nvim='echo "No nesting!"'

  # Use abduco to detach/reattach to an nvim session
  else
    (has abduco) && alias vsess='abduco -A nvim nvim'
  fi
fi

#------------------------------------------
# Private environment variables
#------------------------------------------
source ~/.env

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

set -o notify
shopt -s cdspell >/dev/null 2>&1
#shopt -s nullglob >/dev/null 2>&1
shopt -s extglob >/dev/null 2>&1
shopt -s histappend >/dev/null 2>&1
shopt -s hostcomplete >/dev/null 2>&1
shopt -s interactive_comments >/dev/null 2>&1
shopt -u mailwarn >/dev/null 2>&1
shopt -s no_empty_cmd_completion >/dev/null 2>&1
unset MAILCHECK
ulimit -S -c 0
umask 0022

# -----------------------------------------------------------------------------
# Plugins
# -----------------------------------------------------------------------------

# https://github.com/Bash-it/bash-it
#export BASH_IT="$HOME/.bash_it"
#(has $BASH_IT) && source $BASH_IT/bash_it.sh

# https://github.com/nojhan/liquidprompt
(has ~/.liquidprompt) && [[ $- = *i* ]] && source ~/.liquidprompt/liquidprompt

# http://direnv.net
(has direnv) && eval "$(direnv hook $(shell))" 

# https://github.com/junegunn/fzf
has ~/.fzf.$(shell) && source ~/.fzf.$(shell)


export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--select-1 --exit-0 --preview '[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (rougify {} || coderay {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
#export FZF_ALT_C_COMMAND="cd ~/; bfs -type d -nohidden | sed s/^\./~/"  
export FZF_ALT_C_COMMAND="bfs -type d -nohidden | sed s/^\./~/"  
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"


# -----------------------------------------------------------------------------
# Aliases & Functions
# -----------------------------------------------------------------------------

# python
alias server="python -m SimpleHTTPServer"

# Quickly determine what is keeping mac awake
if has pmset; then
  alias sleepless="pmset -g assertions | egrep '(PreventUserIdleSystemSleep|PreventUserIdleDisplaySleep)'"
fi

if is macos; then
  alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi

