# dotfiles

Config files used for quick and consistent setups. Mostly intended to work across systems.

## Installing

You will need `stow`:

```bash
# feel free to use your preferred package manager or install method
brew install stow 
```

To keep the install process smooth, clone into your `$HOME` directory:

```bash
git clone https://github.com/chalop/.dotfiles.git ~
```

Run `stow` to symlink everything:

```bash
# installs everything except for stuff declared under `.stow-local-ignore`
stow */ 
```

Or just select what you need:

```bash
# just the tmux config
stow tmux 
```

