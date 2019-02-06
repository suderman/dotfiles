# 2019 Jon Suderman
# https://github.com/suderman/dotfiles

# -----------------------------------------------------------------------------
# Environment Variables
# -----------------------------------------------------------------------------
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export EDITOR=nvim
export VISUAL=nvim
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
# Path
# -----------------------------------------------------------------------------
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="./bin:$HOME/bin:$HOME/.dotfiles/bin:$PATH"

# Remove duplicates
export PATH=$(echo $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')

# -----------------------------------------------------------------------------
# Local environment variables
# -----------------------------------------------------------------------------
[[ -f ~/.env ]] && source ~/.env
