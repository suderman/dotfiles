#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# abduco
# -----------------------------------------------------------------------------

# Ctrl-\ to attach/detach abduco session with $EDITOR
if (has abduco) && (has nvim) && (undefined $NVIM_LISTEN_ADDRESS); then

  session(){
    abduco -A $EDITOR $EDITOR
  }

fi
