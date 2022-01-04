#!/bin/sh

# Tools
yay -S fzf tree bat delta

# Dotfiles
git clone --bare https://github.com/suderman/dotfiles.git $HOME/.dotfiles
cd $HOME
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dot checkout dotfiles
dot config --local status.showUntrackedFiles no

# zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/kazhala/dotbare.git ~/.oh-my-zsh/custom/plugins/dotbare

# Install plugin manager for nvim and all plugins
mkdir -p ~/.local/share/nvim/site/autoload
curl -fL https://github.com/junegunn/vim-plug/raw/master/plug.vim > ~/.local/share/nvim/site/autoload/plug.vim
nvim -c PlugInstall

# Tmux plugin manager
mkdir -p ~/.local/share/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.local/share/tmux/plugins/tpm
