# needs: keybindings.zsh and tools.zsh loaded before it, only local.zsh may come after
# plain git clones, fetched on first use
ZSH_PLUGIN_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
zsh_plugin() {
    local name="${1:t}" dir="$ZSH_PLUGIN_DIR/${1:t}"
    [[ -d $dir ]] || git clone --depth 1 "https://github.com/$1.git" "$dir" || return
    source "$dir/${2:-$name.zsh}"
}

# needs to be sourced last, so it wraps every widget defined by the other modules
(( $+widgets[edit-command-line-float] )) || print -u2 "plugins.zsh: keybindings.zsh has to load first, syntax highlighting must be last"
zsh_plugin zsh-users/zsh-syntax-highlighting
