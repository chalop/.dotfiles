# every tool below is optional, a fresh machine will not have them yet
[[ -r "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

(( $+commands[python3] )) && PYTHON_BIN="$(python3 -m site --user-base)/bin"
GO_BIN="/usr/local/go/bin"
export PATH="${PYTHON_BIN:+$PYTHON_BIN:}$GO_BIN:$PATH"
