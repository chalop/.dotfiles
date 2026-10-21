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

# export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS=""
