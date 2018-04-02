#!/usr/bin/env bash

# Add some FZF completions
complete -o default -F _fzf_path_completion l
complete -o default -F _fzf_path_completion la
complete -o nospace -F _fzf_dir_completion z

# ASDF
(has ~/.asdf) && source ~/.asdf/completions/asdf.bash