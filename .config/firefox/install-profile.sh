#!/usr/bin/env zsh

mkdir -p ~/.mozilla/firefox
for profile in ~/.mozilla/firefox/*; do
  if [ -d "${profile}" ]; then
    rm -rf "${profile}/chrome"
    ln -sf ~/.config/firefox/profile/chrome "${profile}/chrome"
    rm -rf "${profile}/user.js"
    ln -sf ~/.config/firefox/profile/user.js "${profile}/user.js"
  fi
done
