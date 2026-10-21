# needs: completion.zsh (compinit), keybindings.zsh (starship has to come after bindkey)
(( $+functions[compdef] )) || print -u2 "tools.zsh: completion.zsh has to load first (compinit)"

# bun
export BUN_INSTALL="/Users/chalop/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(starship init zsh)"

eval "$(fnm env --use-on-cd)"
export PATH=/Users/chalop/.fnm:$PATH
eval "$(pyenv init --path)"
export NM_GLOBAL="$(npm root -g)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
