cite about-alias
about-alias 'custom aliases'

# -----------------------------------------------------------------------------
# NeoVim
# -----------------------------------------------------------------------------
if has nvim; then  

  # Use Neovim as "preferred editor"
  export EDITOR=nvim
  export VISUAL=nvim

  # Use Neovim instead of Vim or Vi
  alias vim=nvim
  alias vi=nvim

  # Check if inside a nvim session
  if defined "$NVIM_LISTEN_ADDRESS"; then

    # disallow nesting of nvims within nvims
    (has nvr) && alias nvim=nvr
    (has nvr) || alias nvim='echo "No nesting!"'

  # Use abduco to detach/reattach to an nvim session
  else
    (has abduco) && alias vsess='abduco -A nvim nvim'
  fi
fi

# -----------------------------------------------------------------------------
# Aliases & Functions
# -----------------------------------------------------------------------------

# Refresh rcm symlinks
alias rcm="rcdn && ln -sf ~/.dotfiles/rcrc ~/.rcrc && rcup"

# python
alias server="python -m SimpleHTTPServer"

# Quickly determine what is keeping mac awake
if has pmset; then
  alias sleepless="pmset -g assertions | egrep '(PreventUserIdleSystemSleep|PreventUserIdleDisplaySleep)'"
fi

if is macos; then
  alias lock="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
fi

# Path on separate lines
path() {
  echo $PATH | tr ':' '\n'
}