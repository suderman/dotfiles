# 2015 Jon Suderman
# https://github.com/suderman/local

# MySQL suffix shortcut
mysqls() {
  mysql --defaults-group-suffix=$1
}

# Kick a service to make sure it's running
if has d; then
  kick() {
    has ~/docker/$1 && 
    defined $(cd ~/docker/$1 && d info | grep stopped) && 
    cd ~/docker/$1 && d refresh
  }
fi

# Wake MacPro and SSH in
macpro() {
  curl api.lan/den/macpro/wake
  sleep 1
  ssh macpro
}

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}

# Change directory using ranger
rcd() {
  tempfile='/tmp/chosendir'
  ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
  ls -lah
}
