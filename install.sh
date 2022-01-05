#!/bin/sh

# tools
sudo pacman -S fzf tree bat ueberzug mpv sxiv inkscape libreoffice-fresh ffmpeg graphicsmagick ghostscript
paru -S lf delta

# dotfiles
git clone --bare https://github.com/suderman/dotfiles.git ~/.cfg
git --git-dir=$HOME/.cfg config --local status.showUntrackedFiles no
git --git-dir=$HOME/.cfg --work-tree=$HOME checkout dotfiles

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

# curl -fL https://github.com/slavistan/lfbundle/raw/master/lfbundle-cleaner > /usr/local/lib/lfbundle-cleaner
