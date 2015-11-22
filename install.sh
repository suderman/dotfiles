#!/bin/bash

# 2015 Jon Suderman
# https://github.com/suderman/dotfiles

# Open a terminal and run this command:
# bash <(curl https://raw.githubusercontent.com/suderman/local/master/install.sh)

# Helper methods for prettier shell scripting - http://suderman.github.io/shelper
eval "$(cat ~/.local/share/shelper.sh || curl suderman.github.io/shelper/shelper.sh)"
installing() { msg "Installing $(cyan "$1")..."; }

# Ask for the administrator password upfront and run a keep-alive to update 
# existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# -------------------------------------------------------------------------
# Make sure Homebrew is installed
# -------------------------------------------------------------------------
if hasnt /usr/local/bin/brew && hasnt ~/.linuxbrew/bin/brew; then
  installing "Homebrew"

  # OS X's Homebrew will need XCode and command line tools
  if is osx; then 

    # Ensure Xcode with command line tools is installed
    if hasnt /Applications/Xcode.app; then 
       msg "Xcode.app is missing! Install that & command line tools first."
       exit 1
    elif hasnt /usr/bin/make || hasnt /usr/bin/gcc; then 
       msg "Command line tools are missing! Install that first."
       exit 1
    fi

    # Install Homebrew
    ruby -e "$(curl -fsSL raw.githubusercontent.com/Homebrew/install/master/install)"

  # Ubuntu's Homebrew has its own dependencies served via apt-get
  elif is ubuntu; then

    sudo apt-get update
    sudo apt-get install build-essential curl git m4 ruby texinfo        \
                         libbz2-dev libcurl4-openssl-dev libexpat-dev    \
                         libncurses-dev zlib1g-dev
    # Install Homebrew
    ruby -e "$(curl -fsSL raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"

  fi
fi
# -------------------------------------------------------------------------

# Make sure git-clone-pull is installed
# https://github.com/suderman/git-clone-pull
installing "git-clone-pull"
curl -fsSL suderman.github.io/git-clone-pull/install | sh

# Git clone/pull this repo to the home directory
installing "~/.dotfiles"
git clone-pull https://github.com/suderman/dotfiles.git ~/.dotfiles

# Symlink private repo if available
if has ~/.private/dotfiles; then
  rm -f ~/.dotfiles/private && ln -s ~/.private/dotfiles ~/.dotfiles/private
fi

# https://github.com/thoughtbot/rcm
installing "rcm"
brew install thoughtbot/formulae/rcm

# -------------------------------------------------------------------------
# IMPORTANT - this step decides which which rcrc file is used with rcm!
# -------------------------------------------------------------------------
msg "Running rcup"

# Consistently set hostname variable (OS X is odd here)
HOSTNAME=$(hostname)
is osx && HOSTNAME=$(scutil --get ComputerName)

# If there's a host match, set the rcrc
if has ~/.dotfiles/host-$HOSTNAME; then
  RCRC="~/.dotfiles/host-$HOSTNAME/rcrc" rcup

# Otherwise, go by OS type
else
  is ubuntu && RCRC="~/.dotfiles/tag-ubuntu/rcrc" rcup
  is osx    && RCRC="~/.dotfiles/tag-osx/rcrc" rcup
fi
# -------------------------------------------------------------------------

msg "Sourcing environment variables"
source ~/.sh/path.sh
source ~/.sh/env.sh

msg "Running update"
update
