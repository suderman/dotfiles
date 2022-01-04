#!/bin/sh

# tools
yay -S fzf tree bat delta

# dotfiles
git clone --bare https://github.com/suderman/dotfiles.git ~/.dotfiles
git --git-dir=$HOME/.dotfiles config --local status.showUntrackedFiles no
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout dotfiles

# persist git credentials
git config --global credential.helper store

# zsh plugins
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/kazhala/dotbare.git ~/.oh-my-zsh/custom/plugins/dotbare

# nvim plugins
mkdir -p ~/.local/share/nvim/site/autoload
curl -fL https://github.com/junegunn/vim-plug/raw/master/plug.vim > ~/.local/share/nvim/site/autoload/plug.vim
nvim -c PlugInstall

# tmux plugins
mkdir -p ~/.local/share/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
