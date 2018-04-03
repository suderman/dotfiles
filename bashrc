# 2018 Jon Suderman
# https://github.com/suderman/dotfiles

# -----------------------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------------------
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export EDITOR=vim
export VISUAL=vim
export XDG_CONFIG_HOME="$HOME/.config"

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
set -o notify
shopt -s cdspell >/dev/null 2>&1
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
# Bash-It including plugins such as FZF
# https://github.com/Bash-it/bash-it
#
# bash-it enable plugin alias-completion base direnv extract fasd fzf git history rbenv
# bash-it enable alias clipboard general
# bash-it enable completion bash-it brew bundler composer defaults docker-compose docker gem git makefile npm pip pip3 pipenv rake rvm ssh system  
# -----------------------------------------------------------------------------
if [ -e ~/.bash_it ]; then
  export BASH_IT="$HOME/.bash_it"
  export BASH_IT_THEME="powerline-naked"
  source $BASH_IT/bash_it.sh
fi

# -----------------------------------------------------------------------------
# Custom bash files
# -----------------------------------------------------------------------------
for f in ~/.dotfiles/bash/*.bash; do [[ -f "$f" ]] && source "$f"; done

# -----------------------------------------------------------------------------
# Local environment variables
# -----------------------------------------------------------------------------
[[ -f ~/.env ]] && source ~/.env
