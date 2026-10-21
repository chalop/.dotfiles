export TILE_PATH="$HOME/scripts/tile-manager"
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"

# ---- options ----
setopt IGNORE_EOF
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_MINUS
setopt INTERACTIVE_COMMENTS LONG_LIST_JOBS

# ---- history ----
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt EXTENDED_HISTORY SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_VERIFY

# ---- completion ----
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

# ---- line editing ----
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

# ---- plugins ----
# plain git clones, fetched on first use
ZSH_PLUGIN_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"
zsh_plugin() {
    local name="${1:t}" dir="$ZSH_PLUGIN_DIR/${1:t}"
    [[ -d $dir ]] || git clone --depth 1 "https://github.com/$1.git" "$dir" || return
    source "$dir/${2:-$name.zsh}"
}

# ---- aliases ----
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -- -='cd -'
alias md='mkdir -p'
alias rd=rmdir
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

alias python="python3"
alias gs="git status"
alias gc="git add . && git commit -a"
alias gl="git log --oneline"
alias gph="git push -u origin"
alias gpl="git pull origin"
alias vim="nvim"
alias es="expo start"
alias ti="tree -I node_modules"
alias ls="lsd"
alias rr="ranger"
alias tree="lsd --tree"
alias rc="vim ~/.zshrc"
alias soce="source ~/.zshrc"
alias yt-mp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias h-search="history | grep"
alias cclear="echo -n -e \"\e[2J\e[3J\e[1;1H\""
alias e="exit"
alias gg="lazygit"
alias tm="tmux"
alias sed="gsed"

src() {
    cd "${PWD/\/src\/*//src/../}"
}

mkcd(){
    mkdir -p $@ && cd ${@:$#}
}

cwd(){
    pwd | pbcopy
}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS=""

# ---- tools ----
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

# needs to be sourced last, so it wraps every widget defined above
zsh_plugin zsh-users/zsh-syntax-highlighting
