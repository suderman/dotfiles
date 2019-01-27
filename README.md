suderman dotfiles!
========================

What is this?
-------------

This is my collection of scripts and configuration files for all of my systems, 
including macOS and Linux. 

I keep my dotfiles symlinked from `~/.dotfiles` to my home directory. I use 
[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) to organize my shell scripts and 
[rcm](https://github.com/thoughtbot/rcm) to manage my dotfiles nicely.  

Installation
------------ 

Clone this repo and symlink rcm's configuration file:  

    git clone git@github.com:suderman/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/rcrc ~/.rcrc   

clone oh-my-zsh:

    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

clone tmux plugin manager:

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

clone minpac:

    git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac

Clone fzf:

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

Install rcm and symlink all the dotfiles:  

    brew install thoughtbot/formulae/rcm
    rcup

Essential Tools
-----------------

Install tmux:

    brew install tmux

Install vim and neovim:  

    brew install vim
    brew install neovim

Additional Tools
-----------------

Install python:  

    brew install python2
    brew install python3
	
    $(brew --prefix)/bin/pip2 install --user --upgrade neovim
    $(brew --prefix)/bin/pip3 install --user --upgrade neovim neovim-remote

Install ruby:

    brew install ruby
    $(brew --prefix)/bin/gem install neovim

Install nodejs:

    brew install nodejs
    $(brew --prefix)/bin/npm install -g neovim

Install preview tools:

    brew install highlight
    $(brew --prefix)/bin/gem install coderay rouge

Install a few grepping tools:  

    brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
    brew install ripgrep-bin
    brew install the_silver_searcher
    brew install ack

Install my own for managing ssh configuration:

    curl suderman.github.io/sshconfig/install | sh

Keep this configuration updated:

    cd ~/.dotfiles && git pull
    cd ~/.oh-my-zsh && git pull
    cd ~/.fzf && git pull
    nvim -E -c PackUpdate -c q
    ~/.tmux/plugins/tpm/bin/install_plugins all
    ~/.tmux/plugins/tpm/bin/update_plugins all
    rcdn && ln -sf ~/.dotfiles/rcrc ~/.rcrc && rcup
    brew update && brew upgrade

Install:

    brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
    brew install vim neovim python2 python3 ruby highlight the_silver_searcher ack ripgrep
    pip2 install --user --upgrade neovim
    pip3 install --user --upgrade neovim neovim-remote
    $(brew --prefix)/bin/gem install neovim coderay rouge
