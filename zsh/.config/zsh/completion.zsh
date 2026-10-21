# needs: nothing, but must load before tools.zsh (complete/compdef need compinit)
autoload -Uz compinit
# only regenerate the dump once a day, otherwise trust the cache
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''

# to only recommend certain filetypes for sioyek
compdef '_files -g "*.(pdf|epub)"' sioyek
