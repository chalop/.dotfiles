#!/bin/bash
# Sets up a brand new macOS machine: Xcode CLT, Homebrew, then per group the
# brew packages (brew/Brewfile.<group>) and the stow packages.
#
#   ./bootstrap.sh            ask for each group
#   ./bootstrap.sh --all      install every group without asking
#   ./bootstrap.sh core desktop   only the named groups, without asking
#
# Safe to run again, brew bundle and stow --restow are idempotent.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# group:description:stow packages
GROUPS_DEF=(
    "core:shell, editor and terminal tooling:zsh nvim tmux lazygit scripts home"
    "desktop:tiling window manager and window borders:aerospace"
    "apps:terminal emulators and GUI apps:ghostty alacritty sioyek surfingkeys herdr"
)

say() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }
warn() { printf '\033[33mwarning:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[31merror:\033[0m %s\n' "$*" >&2; exit 1; }

[[ "$(uname -s)" == Darwin ]] || die "macOS only"
[[ "$DOTFILES" == "$HOME/.dotfiles" ]] || warn "expected the repo at ~/.dotfiles, found $DOTFILES, stow links are relative to it"

# which groups to install
SELECTED=()
ASK=1
if [[ $# -gt 0 ]]; then
    ASK=0
    if [[ "$1" == --all ]]; then
        for def in "${GROUPS_DEF[@]}"; do SELECTED+=("${def%%:*}"); done
    else
        for name in "$@"; do
            found=0
            for def in "${GROUPS_DEF[@]}"; do [[ "${def%%:*}" == "$name" ]] && found=1; done
            [[ $found -eq 1 ]] || die "unknown group '$name'"
            SELECTED+=("$name")
        done
    fi
else
    say "Pick what to install"
    for def in "${GROUPS_DEF[@]}"; do
        IFS=: read -r name desc _ <<< "$def"
        read -r -p "  $name - $desc [y/N] " reply
        [[ "$reply" =~ ^[Yy] ]] && SELECTED+=("$name")
    done
fi
[[ ${#SELECTED[@]} -gt 0 ]] || { echo "Nothing selected."; exit 0; }

# 1. Xcode command line tools (git, make, clang), the installer is a GUI prompt
if ! xcode-select -p > /dev/null 2>&1; then
    say "Installing Xcode command line tools"
    xcode-select --install || true
    die "finish the Xcode installer dialog, then run ./bootstrap.sh again"
fi

# 2. Homebrew
find_brew() {
    for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        [[ -x "$b" ]] && { echo "$b"; return; }
    done
    return 1
}
if ! BREW="$(find_brew)"; then
    say "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    BREW="$(find_brew)" || die "Homebrew install failed"
fi
eval "$("$BREW" shellenv)"

# 3. packages and symlinks per group
for def in "${GROUPS_DEF[@]}"; do
    IFS=: read -r name _ packages <<< "$def"
    [[ " ${SELECTED[*]} " == *" $name "* ]] || continue

    # recent Homebrew refuses to load anything from a third party tap until it is trusted
    taps="$(sed -n 's/^tap "\([^"]*\)".*/\1/p' "$DOTFILES/brew/Brewfile.$name")"
    if [[ -n "$taps" ]] && brew trust --help > /dev/null 2>&1; then
        echo "[$name] needs these third party taps:"
        # shellcheck disable=SC2001
        echo "$taps" | sed 's/^/    /'
        read -r -p "  Trust them so brew can install from them? [y/N] " reply
        if [[ "$reply" =~ ^[Yy] ]]; then
            # shellcheck disable=SC2086
            brew trust --tap $taps
        else
            warn "[$name] skipped, brew would refuse to install from untrusted taps"
            continue
        fi
    fi

    say "[$name] brew bundle"
    brew bundle --file "$DOTFILES/brew/Brewfile.$name"

    say "[$name] stow $packages"
    # shellcheck disable=SC2086
    err="$(mktemp)"
    if ! stow -d "$DOTFILES" -t "$HOME" --restow --simulate $packages 2> "$err"; then
        cat "$err" >&2
        warn "[$name] stow found existing files in the way, nothing was linked."
        warn "move or delete the files listed above (back them up first) and run ./bootstrap.sh $name"
        rm -f "$err"
        continue
    fi
    rm -f "$err"
    # herdr writes logs, sockets and sessions into its config dir, make sure stow links
    # single files into it instead of linking the whole dir into this repo
    [[ " $packages " == *" herdr "* ]] && mkdir -p "$HOME/.config/herdr"
    # shellcheck disable=SC2086
    stow -d "$DOTFILES" -t "$HOME" --restow $packages

    # aerospace needs its config generated from the tracked and untracked parts
    if [[ " $packages " == *" aerospace "* ]]; then
        "$DOTFILES/aerospace/.config/aerospace/build.sh"
    fi
done

# 4. things stow and brew do not cover
if command -v herdr > /dev/null 2>&1; then
    for plugin in zsh-edit last-workspace; do
        if ! herdr plugin list 2> /dev/null | grep -q "local.$plugin"; then
            say "Linking the herdr $plugin plugin"
            herdr plugin link "$DOTFILES/herdr/.config/herdr-plugins/$plugin"
        fi
    done
fi

if [[ " ${SELECTED[*]} " == *" core "* ]]; then
    TPM="$HOME/.tmux/plugins/tpm"
    if [[ ! -d "$TPM" ]]; then
        say "Installing tmux plugin manager"
        git clone --depth 1 https://github.com/tmux-plugins/tpm "$TPM"
    fi
fi

say "Done. Manual steps left"
cat <<'EOF'
  - open a new terminal, zsh plugins and nvim plugins install themselves on first start
  - tmux: start tmux and press prefix + I to install the plugins
  - herdr:  not on brew, install it from https://herdr.dev, then run ./bootstrap.sh apps to link its plugins
  - rust:   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  - go:     https://go.dev/dl/ (the shell config looks in /usr/local/go/bin)
  - bun:    curl -fsSL https://bun.sh/install | bash
  - font:   MonoLisa Nerd Font is paid and not on brew, install it by hand (used by ghostty)
  - desktop group: open AeroSpace once and grant it Accessibility permission, then remove the
                   Option-number shortcuts under System Settings > Keyboard > Keyboard Shortcuts >
                   Mission Control so they do not clash with the workspace bindings
  - machine specific shell overrides go in ~/.config/zsh/local.zsh (untracked)
EOF
