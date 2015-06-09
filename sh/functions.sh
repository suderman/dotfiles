# 2015 Jon Suderman
# https://github.com/suderman/local

# MySQL suffix shortcut
mysqls() {
  mysql --defaults-group-suffix=$1
}

# Wake MacPro and SSH in
macpro() {
  curl https://api.lan/den/macpro/wake && ssh macpro
}

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}

# Change directory using ranger
ranger-cd() {
  tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
  ls -lah
}
ranger-cd-wrapper() {
  ranger-cd
  ls -lah
}

