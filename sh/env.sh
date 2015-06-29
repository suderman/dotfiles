# 2015 Jon Suderman
# https://github.com/suderman/local

#---------------------------
# Environment Variables
#---------------------------

# Some of these settings will look here
brew_prefix="/usr/local"
(has brew) && brew_prefix="$(brew --prefix)"

# Manually set your language environment
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# use vim as an editor
export EDITOR=vim
export VISUAL=vim

# Would be nice if configuration all went in one directory
export XDG_CONFIG_HOME="$HOME/.config"

# https://github.com/georgebrock/1pass
(has 1pass) && export ONEPASSWORD_KEYCHAIN="$HOME/Dropbox/sync/1Password.agilekeychain"

# https://github.com/jimeh/tmuxifier
if has tmuxifier; then 
  export TMUXIFIER_LAYOUT_PATH="$HOME/.local/tmux/layouts"
  eval "$(tmuxifier init -)"
fi

# chruby
if has $brew_prefix/share/chruby/chruby.sh; then
  source $brew_prefix/share/chruby/chruby.sh
  source $brew_prefix/share/chruby/auto.sh
fi

# ec2-api-tools
(has /usr/libexec/java_home) && export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_HOME="$brew_prefix/Library/LinkedKegs/ec2-api-tools/libexec"

# https://github.com/suderman/launchup
(is osx) && export LAUNCHD_PLISTS=$HOME/.local/osx/launchd
 
# boot2docker
(is osx) && export DOCKER_HOST=tcp://localhost:4243

#------------------------------------------
# Cross-platform host & port configuration
#------------------------------------------

# dotfiles/ssh/config.*
# secret/dotfiles/ssh/config.*
export HOSTS="nuc lan wan macpro pi tigerblood bam garnet talisman cnrl csweb csmysql"

# osx/bin/copy
# dotfiles/ssh/config.scp
export PORT_SCP=2222

# bin/ql
# dotfiles/ssh/config.quicklook
# osx/launchd/user.agent.quicky.plist
export PORT_QUICKLOOK=2223

# ubuntu/bin/pbcopy
# dotfiles/ssh/config.pasteboard
# osx/launchd/user.agent.pbcopy.plist
export PORT_PBCOPY=2224

# ubuntu/bin/pbpaste
# dotfiles/ssh/config.pasteboard
# osx/launchd/user.agent.pbpaste.plist
export PORT_PBPASTE=2225
  
# osx/bin/chrome
# dotfiles/ssh/config.reload-chrome
# osx/launchd/user.agent.reload-chrome.plist
export PORT_RELOAD_CHROME=2226


#-----------------------------
# Secret environment variables
#-----------------------------
source if "$HOME/.local/secret/sh/env.sh"

