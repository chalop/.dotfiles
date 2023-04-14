. "$HOME/.cargo/env"

PYTHON_BIN="$(python3 -m site --user-base)/bin"
GO_BIN="/usr/local/go/bin"
export PATH="$PYTHON_BIN:$GO_BIN:$PATH"


export PATH=$PATH:/usr/local/go/bin

path=(
    $path
    $(go env GOPATH)/bin
    /usr/local/opt/qt@5/bin
    /Users/chalop/.local/bin
    /Users/chalop/Projects/sioyek/build/sioyek.app/Contents/MacOS/
    /Applications/Stats.app/Contents/Resources
)
