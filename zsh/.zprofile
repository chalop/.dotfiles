# extra directories, only the ones that exist on this machine are added
path=(
    $path
    ${GOPATH:-$HOME/go}/bin(N-/)
    /usr/local/opt/qt@5/bin(N-/)
    $HOME/.local/bin(N-/)
    $HOME/Projects/sioyek/build/sioyek.app/Contents/MacOS(N-/)
    /Applications/Stats.app/Contents/Resources(N-/)
    /Applications/FontForge.app/Contents/Resources/opt/local/bin(N-/)
)

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# apple silicon, then intel
for brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [[ -x $brew ]] && { eval "$($brew shellenv)"; break }
done
unset brew
