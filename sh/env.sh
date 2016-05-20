# 2015 Jon Suderman
# https://github.com/suderman/dotfiles

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

# chruby
if has $brew_prefix/share/chruby/chruby.sh; then
  source $brew_prefix/share/chruby/chruby.sh
  source $brew_prefix/share/chruby/auto.sh
fi

# ec2-api-tools
(has /usr/libexec/java_home) && export JAVA_HOME="$(/usr/libexec/java_home)"
export EC2_HOME="$brew_prefix/Library/LinkedKegs/ec2-api-tools/libexec"

#------------------------------------------
# Cross-platform host & port configuration
#------------------------------------------

# dotfiles/ssh/config.*
# secret/dotfiles/ssh/config.*
export HOSTS="nuc lan wan mini9 macpro pi tigerblood bam garnet cnrl csweb csmysql"

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


#------------------------------------------
# Tag & Host specific environment variables
#------------------------------------------
for env in ~/.sh/env-*.sh; do source $env; done
