suderman-style dotfiles!
========================

What's this?
------------

This is my collection of scripts and configuration files for all of my systems, 
including OS X and Ubuntu. 

I keep my dotfiles symlinked from `~/.dotfiles` to my home directory. I use 
[rcm](https://github.com/thoughtbot/rcm) to manage them nicely.  

Installation
------------

First, it's a good idea to set the hostname of the computer, especially if it 
matches one of the hostnames in this repo. Second, make sure the machine either 
has [Homebrew](http://brew.sh/) installed, or is prepared for Homebrew.  

On OS X, this means installing XCode along with its command line tools.
It'd also be a good idea to check off iTerm or Terminal under 
`System Preferences -> Security & Privacy -> Accessibility` 
if you want to automate the installation of Mac App Store apps via 
AppleScript.

Once ready, open a terminal and run this command:  
`bash <(curl https://raw.githubusercontent.com/suderman/dotfiles/master/install.sh)`

Usage
-----

Symlinked dotfiles are brought down with `rcdn` and back up again with
`rcup -B hostname -t osx/ubuntu rcrc && rcup`, using the `~/.rcrc` for 
configuration. Run `~/.dotfiles/bin/rcm` to make this step easy. Additional, 
private dotfiles are to be put `~/.dotfiles/private`. Since this directory 
isn't tracked with git, I like to sync everything with ownCloud. I create a 
symlink from `~/ownCloud/Dotfiles` to `~/.dotfiles`. Environment variables 
including the PATH are sourced from the home directory's `.env` file.  User 
commands are stored in the home directory's `~/bin` folder, including the 
`update` command (which is a good command to periodically run!).

ownCloud Syncing
----------------
`ln -sf ~/.sync-exclude.lst ~/Library/Application\ Support/ownCloud/sync-exclude.lst`  
`owncloudcmd -u USER -p PASSWORD -h --exclude ~/.sync-exclude.lst --trust ~/ownCloud https://OWNCLOUDURL/`
