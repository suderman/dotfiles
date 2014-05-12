# 2014 Jon Suderman
# https://github.com/suderman/local

#---------------------------
# ZSH Environment Variables
#---------------------------

# Some of these settings will look here
brew_prefix="/usr/local"
! command -v brew >/dev/null 2>&1 || { brew_prefix="$(brew --prefix)" }

# Manually set your language environment
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# use vim as an editor
export EDITOR=vim
export VISUAL=vim

# https://github.com/georgebrock/1pass
! command -v 1pass >/dev/null 2>&1 || { 
  export ONEPASSWORD_KEYCHAIN="$HOME/Dropbox/Library/1Password.agilekeychain"
}

# https://github.com/jimeh/tmuxifier
! command -v tmuxifier >/dev/null 2>&1 || { 
  export TMUXIFIER_LAYOUT_PATH="$HOME/.local/dotfiles/tmux/layouts"
  eval "$(tmuxifier init -)"
}

# chruby
if [ -f "$brew_prefix/share/chruby/chruby.sh" ]; then
  source $brew_prefix/share/chruby/chruby.sh
  # auto-switching
  source $brew_prefix/share/chruby/auto.sh
  # https://github.com/sstephenson/ruby-build/issues/193
  export CPPFLAGS=-I/opt/X11/include
fi

# ec2-api-tools
if [ -d /usr/libexec/java_home ]; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi
export EC2_HOME="$brew_prefix/Library/LinkedKegs/ec2-api-tools/libexec"

# OS X app installer
if [ -d ~/Dropbox/Installers ]; then
  export APP_SOURCE=~/Dropbox/Installers
fi

# http://direnv.net
! command -v direnv >/dev/null 2>&1 || { 
  eval "$(direnv hook zsh)" 
}

# https://github.com/suderman/launchup
if [[ "$PLATFORM" == 'osx' ]]; then
  export LAUNCHD_PLISTS=$HOME/.local/osx/launchd
fi


#----------------------------------
# Cross-platform host & port configuration
#----------------------------------

# dotfiles/ssh/config.*
# secret/dotfiles/ssh/config.*
export HOSTS="macpro pi tigerblood bam garnet talisman cnrl handbill"

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

if [ -f $HOME/.local/secret/zsh/env.zsh ]; then
  source $HOME/.local/secret/zsh/env.zsh
fi

