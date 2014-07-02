# 2014 Jon Suderman
# https://github.com/suderman/local

# Make these commands ask before clobbering a file
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Use human-readable filesizes
alias du="du -h"
alias df="df -h"

# Quick access to dotfiles
alias dotfiles='cd $HOME/.local/dotfiles; ls -lh'

# bundler laziness
if has bundle; then
  alias be="bundle exec"
  alias bi="bundle install --path vendor/bundle"
  alias bb="bundle install --binstubs"
  alias bl="bundle list"
  alias bs="bundle show"
  alias bu="bundle update"
  alias bp="bundle package"
fi

# python
alias server="python -m SimpleHTTPServer"

# Add self-signed certificate
if has security; then
  alias trust="sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "
fi

# docker
alias dk='docker'

# docker last - get id from last container
alias dkl='docker ps -l -q'

# docker ip - get the ip address from a container
alias dkip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# docker remove - remove all stopped containers
alias dkrm='docker rm $(docker ps --no-trunc -a -q)';

# docker remove images - remove images labeled <none>
alias dkrmi='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")';

# docker daemon - run an image daemonized
alias dkd="docker run -d"

# docker terminal - run an image interactively in the terminal
alias dkt="docker run -i -t"

# docker build - build a tagged image
dkb() { docker build -t="$1" .; }

# docker stop - stop a specified container, or all of them
dkstop() { if [[ ! -z ${1} ]]; then docker stop ${1}; else docker stop $(docker ps -q); fi };

# docker clean - stop all containers, remove all containers, remove all images
alias dkclean='dkstop; dkrm; dkrmi';

# docker images
alias dki="docker images";

# docker processes
alias dkps="docker ps -a";

# dockers - all images and processes
alias dks="docker images; docker ps -a"

unalias d 2>/dev/null
unalias sudo 2>/dev/null
