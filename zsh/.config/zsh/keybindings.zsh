bindkey -e
bindkey '^R' history-incremental-search-backward
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
# opt + arrows / opt + b,f
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# edit the current command in nvim, ctrl-x ctrl-e
# floating popup in tmux and herdr (via plugin), zoomed pane on older herdr
# quit nvim to bring the command back to the prompt (without running it)
autoload -Uz edit-command-line
zle -N edit-command-line

_edit_in_float() {
    local file=$1 cmd="${EDITOR:-nvim} -c 'set ft=zsh' $1"
    if [[ -n $TMUX ]]; then
        tmux display-popup -E -w 80% -h 60% -b rounded "$cmd"
    elif [[ -n $HERDR_ENV ]]; then
        # popup from the local.zsh-edit plugin (herdr/.config/herdr-plugins), needs herdr >= 0.9
        if herdr plugin pane open --plugin local.zsh-edit --entrypoint edit --placement popup \
            --width 80% --height 60% --env ZSH_EDIT_FILE=$file --env EDITOR="${EDITOR:-nvim}" > /dev/null 2>&1; then
            until [[ -e $file.done ]]; do sleep 0.1; done
            rm -f $file.done
            return 0
        fi
        # older herdr has no popups, use a temporary zoomed pane instead
        local pane=$(herdr pane split --current --direction down --focus | grep -oE 'w[0-9]+:p[0-9]+' | tail -1)
        [[ -n $pane ]] || return 1
        herdr pane zoom --pane $pane > /dev/null
        herdr pane run $pane "$cmd; touch $file.done; exit" > /dev/null
        # the pane may have been closed by hand, so don't wait forever
        until [[ -e $file.done ]] || ! herdr pane get $pane > /dev/null 2>&1; do sleep 0.1; done
        herdr pane close $pane > /dev/null 2>&1
        rm -f $file.done
    else
        return 1
    fi
}

edit-command-line-float() {
    local file=$(mktemp "${TMPDIR:-/tmp}/zshcmd.XXXXXX")
    print -r -- "$BUFFER" > $file
    if _edit_in_float $file; then
        BUFFER=$(<$file)
        CURSOR=$#BUFFER
        zle redisplay
    else
        zle edit-command-line
    fi
    rm -f $file
}
zle -N edit-command-line-float
bindkey '^X^E' edit-command-line-float
