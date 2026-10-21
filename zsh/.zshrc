export TILE_PATH="$HOME/scripts/tile-manager"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"

# modules live in ~/.config/zsh, a module not listed here is NOT loaded and order matters
zsh_modules=(
    options         # independent: options, history, aliases, functions
    history
    completion      # before tools (compinit)
    keybindings     # before tools (starship) and plugins (widgets)
    aliases
    functions
    tools           # needs completion, keybindings
    plugins         # last, syntax highlighting wraps every widget before it
    local           # optional, untracked, machine specific overrides
)

for module in $zsh_modules; do
    [[ -r $XDG_CONFIG_HOME/zsh/$module.zsh ]] && source "$XDG_CONFIG_HOME/zsh/$module.zsh"
done
unset module zsh_modules
