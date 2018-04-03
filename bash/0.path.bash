#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# PATH
# -----------------------------------------------------------------------------

# Homebrew bin directories
path_prepend /usr/local/bin /usr/local/sbin

# Linuxbrew bin directories
path_prepend /home/linuxbrew/.linuxbrew/bin /home/linuxbrew/.linuxbrew/sbin

# Local bin directories
path_prepend ./bin ~/bin ~/.dotfiles/bin ~/Support/Bin

# Vim bin
path_append ~/.vim/bin

# Python bin directories
path_append ~/Library/Python/2.7/bin ~/Library/Python/3.6/bin  