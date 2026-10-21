export TILE_PATH="$HOME/scripts/tile-manager"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"

# modules live in ~/.config/zsh and load in this order, a module not listed here is NOT loaded:
#   options, history, aliases, functions   independent
#   completion                             before tools (compinit)
#   keybindings                            before tools (starship) and plugins (widgets)
#   tools                                  needs completion, keybindings
#   plugins                                last, syntax highlighting wraps every widget before it
#   local                                  optional, untracked, machine specific overrides
for module in options history completion keybindings aliases functions tools plugins local; do
    [[ -r $XDG_CONFIG_HOME/zsh/$module.zsh ]] && source "$XDG_CONFIG_HOME/zsh/$module.zsh"
done
unset module
