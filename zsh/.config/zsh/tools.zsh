# needs: completion.zsh (compinit), keybindings.zsh (starship has to come after bindkey)
(( $+functions[compdef] )) || print -u2 "tools.zsh: completion.zsh has to load first (compinit)"

# bun
export BUN_INSTALL="$HOME/.bun"
[[ -d $BUN_INSTALL ]] && export PATH="$BUN_INSTALL/bin:$PATH"

(( $+commands[starship] )) && eval "$(starship init zsh)"

(( $+commands[fnm] )) && eval "$(fnm env --use-on-cd)"
[[ -d $HOME/.fnm ]] && export PATH=$HOME/.fnm:$PATH
(( $+commands[pyenv] )) && eval "$(pyenv init --path)"
(( $+commands[npm] )) && export NM_GLOBAL="$(npm root -g)"

autoload -U +X bashcompinit && bashcompinit
(( $+commands[terraform] )) && complete -o nospace -C $commands[terraform] terraform
