#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# ASDF
# -----------------------------------------------------------------------------
if (has ~/.asdf); then 
  source ~/.asdf/asdf.sh
  source ~/.asdf/completions/asdf.bash
fi

if (has asdf) && (has fzf); then 
  
  adf-install() {
    local lang=${1}

    if [[ ! $lang ]]; then
      lang=$(asdf plugin-list | fzf)
    fi

    if [[ $lang ]]; then
      local versions=$(asdf list-all $lang | fzf -m)
      if [[ $versions ]]; then
        for version in $(echo $versions); do
          asdf install $lang $version; 
        done
      fi
    fi
  }

  adf-uninstall() {
    local lang=${1}

    if [[ ! $lang ]]; then
      lang=$(asdf plugin-list | fzf)
    fi

    if [[ $lang ]]; then
      local versions=$(asdf list $lang | fzf -m)
      if [[ $versions ]]; then
        for version in $(echo $versions); do
          asdf uninstall $lang $version; 
        done
      fi
    fi
  }

fi
