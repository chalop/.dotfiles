export TILE_PATH="$HOME/scripts/tile-manager"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"

# modules live in ~/.config/zsh, order matters:
#  - completion before anything calling compdef/complete (tools)
#  - plugins last, syntax highlighting has to wrap every widget defined before it
#  - local.zsh (optional, not tracked) for machine specific overrides
for module in options history completion keybindings aliases functions tools plugins local; do
    [[ -r $XDG_CONFIG_HOME/zsh/$module.zsh ]] && source "$XDG_CONFIG_HOME/zsh/$module.zsh"
done
unset module
