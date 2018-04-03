#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# ASDF
# -----------------------------------------------------------------------------

if (has brew) && (has fzf); then 

  brew-install() {
    local inst=$(brew search | fzf -m --preview 'brew info {}')
    if [[ $inst ]]; then
      for prog in $(echo $inst); do
        brew install $prog
      done
    fi
  }

  brew-upgrade() {
    local upd=$(brew leaves | fzf -m)
    if [[ $upd ]]; then
      for prog in $(echo $upd); do
        brew upgrade $prog
      done
    fi
  }

  brew-uninstall() {
    local uninst=$(brew leaves | fzf -m)
    if [[ $uninst ]]; then
      for prog in $(echo $uninst); do
        brew uninstall $prog
      done
    fi
  }


  brew-cask-install() {
    local token
    token=$(brew cask search | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(I)nstall or open the (h)omepage of $token"
        read input
        if [ $input = "i" ] || [ $input = "I" ]; then
            brew cask install $token
        fi
        if [ $input = "h" ] || [ $input = "H" ]; then
            brew cask home $token
        fi
    fi
  }

  brew-cask-uninstall() {
    local token
    token=$(brew cask list | fzf-tmux --query="$1" +m --preview 'brew cask info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepage of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew cask uninstall $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew cask home $token
        fi
    fi
  }

fi
