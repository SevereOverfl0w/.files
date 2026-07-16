export EDITOR=nvim

path=(
  "$HOME/.local/bin"
  "$path[@]"
  "$HOME/.gem/ruby/2.3.0/bin"
  "$HOME/.cargo/bin"
)

export PIPX_BIN_DIR="$HOME/.local/bin"

# https://github.com/android-password-store/Android-Password-Store/issues/173#issuecomment-453686599
export GOPASS_GPG_OPTS='--no-throw-keyids'
export BEMENU_OPTS="--fn 'monospace 12'"
