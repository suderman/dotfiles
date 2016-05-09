# 2015 Jon Suderman
# https://github.com/suderman/dotfiles

# Use human-readable filesizes
alias du="du -h"
alias df="df -h"

# Quick access to dotfiles
alias dotfiles='cd $HOME/./dotfiles; ls -lh'

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

# nuc tmux
is osx && alias nuc="ssh nuc -t '~/.linuxbrew/bin/tmux a'"

# vi is vim
alias vi=vim

# vlc
osxvlc="/opt/homebrew-cask/Caskroom/vlc/2.1.4/VLC.app/Contents/MacOS/VLC"
if has "$osxvlc"; then
  alias vlc="$osxvlc"
fi
alias spycam="vlc http://localhost:9091"

# Add self-signed certificate
if has security; then
  alias trust="sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "
fi

# Homebrew openssl
if has /usr/local/Cellar/openssl/1.0.1h/bin/openssl; then
  alias ssl="/usr/local/Cellar/openssl/1.0.1h/bin/openssl"
fi

# docker compose
alias dc='docker-compose'

# docker ip - get the ip address from a container
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

unalias d 2>/dev/null
unalias sudo 2>/dev/null

#------------------------------------------
# Tag & Host specific aliases
#------------------------------------------
for aliases in ~/.sh/aliases-*.sh; do source $aliases; done
