# launchd
export LAUNCHD_PLISTS="~/.launchd"

# # https://github.com/georgebrock/1pass
# if (has 1pass); then
#   export ONEPASSWORD=""
#   export ONEPASSWORD_KEYCHAIN="$HOME/.private/1Password/1Password.agilekeychain"
#   export ONEPASSWORD_PATH=$(which 1pass)
#   1pass() { 
#     local pass=$(echo $ONEPASSWORD | base64 -D) 
#     echo "$pass" | $ONEPASSWORD_PATH --no-prompt --fuzzy --path "$ONEPASSWORD_KEYCHAIN" "\"$1\""
#   }
# fi
