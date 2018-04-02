suderman-style dotfiles!
========================

What's this?
------------

This is my collection of scripts and configuration files for all of my systems, 
including macOS and Linux. 

I keep my dotfiles symlinked from `~/.dotfiles` to my home directory. I use 
[Bash-it](https://github.com/Bash-it/bash-it) to organize my shell scripts and 
[rcm](https://github.com/thoughtbot/rcm) to manage my dotfiles nicely.  

Installation
------------ 

Clone the Bash-it repo and run the installer:  

    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh

Clone this repo and symlink rcm's configuration file:  

    git clone git@github.com:suderman/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/rcrc ~/.rcrc   

Install rcm and symlink all the dotfiles:  

    brew install thoughtbot/formulae/rcm
    rcup

Additional Tools
-----------------

Install preferred terminal du jour:

    brew install caskroom/cask/therm

Install abduco for session management:

    brew install abduco

Install vim and neovim:  

    brew install vim
    brew install neovim

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

Install command-line fuzzy finder:  

    brew install fzf
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

Install preview tools:

    brew install highlight
    $(brew --prefix)/bin/gem install coderay rouge

Install a few grepping tools:  

    brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
    brew install ripgrep-bin
    brew install the_silver_searcher
    brew install ack
    brew install tavianator/tap/bfs
    brew install fasd

Install version manager:  

    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.4.3

Install a couple of my own for managing ssh and launchd configuration:

    curl suderman.github.io/sshconfig/install | sh
    curl suderman.github.io/launchup/install | sh # -- macos only --

Enable my plugins in Bash-it:

    bash-it enable plugin alias-completion base direnv extract fasd fzf git history rbenv
    bash-it enable alias clipboard general
    bash-it enable completion bash-it brew bundler composer defaults docker-compose docker gem git makefile npm pip pip3 pipenv rake rvm ssh system

Keep this configuration updated:

    cd ~/.dotfiles && git pull
    bash-it update    
    brew update && brew upgrade
    $(brew --prefix)/bin/gem update

Install:

    brew tap burntsushi/ripgrep https://github.com/BurntSushi/ripgrep.git
    brew install abduco vim neovim python2 python3 ruby fzf highlight the_silver_searcher ack ripgrep tavianator/tap/bfs fasd
    pip2 install --user --upgrade neovim
    pip3 install --user --upgrade neovim neovim-remote
    $(brew --prefix)/bin/gem install neovim coderay rouge