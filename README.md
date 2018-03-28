suderman-style dotfiles!
========================

What's this?
------------

This is my collection of scripts and configuration files for all of my systems, 
including macOS and Linux. 

I keep my dotfiles symlinked from `~/.dotfiles` to my home directory. I use 
[rcm](https://github.com/thoughtbot/rcm) to manage them nicely.  

Installation
------------

Clone the repo and symlink rcm's configuration file:  

	git clone git@github.com:suderman/dotfiles.git ~/.dotfiles
	ln -s ~/.dotfiles/rcrc ~/.rcrc

Install rcm and symlink all the dotfiles:  

	brew install rcm
	rcup

Additional Tools
-----------------

Install preferred terminal du jour:

	brew install caskroom/cask/therm

Install vim and neovim:  

	brew install vim
	brew install neovim

Install python and a few vim niceties:  

	brew install python2
	brew install python3
	
	pip2 install --user --upgrade neovim
	pip3 install --user --upgrade neovim
	pip3 install --user --upgrade neovim-remote

Install command-line fuzzy finder:  

	brew install fzf
	/usr/local/opt/fzf/install --key-bindings --completion --no-update-rc

Install a few grepping tools:  

	brew install the_silver_searcher
	brew install ack
	brew install ripgrep

Install a couple of my own for managing ssh and launchd configuration:

	curl suderman.github.io/sshconfig/install | sh
	curl suderman.github.io/launchup/install | sh

