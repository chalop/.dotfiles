# dotfiles

Config files managed with [GNU Stow](https://www.gnu.org/software/stow/). macOS only.

## New machine

```bash
git clone https://github.com/chalop/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

It has to live in `~/.dotfiles`, the symlinks stow creates are relative to it.

`bootstrap.sh` installs the Xcode command line tools and Homebrew if they are missing, then asks per group whether to install it:

| Group | What you get |
|-------|--------------|
| `core` | Shell, editor, multiplexer and everyday CLI tooling. Enough for a comfortable terminal. |
| `desktop` | Tiling window manager with its own hotkeys and workspaces (no SIP changes) and window borders. |
| `apps` | Terminal emulators, a PDF reader, a browser keybinding extension and other GUI apps. |

The exact packages are in `brew/Brewfile.<group>` and the config folders each group links are listed in `bootstrap.sh`.

```bash
./bootstrap.sh            # ask for each group
./bootstrap.sh --all      # everything, no questions
./bootstrap.sh core       # only the named groups
```

If a config already exists where stow wants a symlink, that group is skipped and the conflicting files are listed. Back them up, remove them and run it again.

### Not installed by the script

- **Language toolchains**: the shell config uses them when present. Install links are printed at the end of the bootstrap.
- **The terminal font**: paid, install it by hand.
- **Window manager permissions**: grant it Accessibility on first launch, and remove the system's Option-number Mission Control shortcuts so they do not clash with its workspace bindings.

## Without the script

```bash
brew install stow
brew bundle --file brew/Brewfile.core
stow zsh nvim tmux      # just what you need
```

## Private per-app rules

The window manager reads a single config file and cannot include another one, so the tracked `aerospace.base.toml` only has the generic rules. Rules naming apps you would rather not publish go in `aerospace.local.toml` (untracked, see `aerospace.local.example.toml`), and `aerospace/.config/aerospace/build.sh` joins both into the file the window manager reads. The bootstrap runs it, run it again after editing either file.

## Legacy

Configs I no longer use but want to keep around live in `legacy/`, outside every group. Stow one from there if you want it back:

```bash
stow -d legacy -t ~ yabai
```

## Layout

Every top level folder is a stow package, its contents mirror `$HOME`:

```
zsh/.config/zsh/aliases.zsh  ->  ~/.config/zsh/aliases.zsh
```

Ignore patterns live in a `.stow-local-ignore` inside the package they apply to (stow does not read one at the repo root). Machine specific shell overrides go in `~/.config/zsh/local.zsh`, which is untracked.
