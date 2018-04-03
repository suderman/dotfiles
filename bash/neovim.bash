#!/usr/bin/env bash

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