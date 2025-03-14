# Path to your oh-my-zsh installation.
export ZSH="/Users/chalop/.oh-my-zsh"
export TILE_PATH="$HOME/scripts/tile-manager"
export XDG_CONFIG_HOME="$HOME/.config"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="" # empty in favor of `starship` taking over
# ZSH_HIGHLIGHT_STYLES[comment]='none'

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode zsh-vimode-visual zsh-syntax-highlighting)
# To lazy load NVM, only toggle when needed
# plugins+=(zsh-nvm)
source $ZSH/oh-my-zsh.sh

# unsetopt HIST_VERIFY

setopt IGNORE_EOF

# User configuration
# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$ANDROID_HOME/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools
# export MANPATH="/usr/local/man:$MANPATH"

# For a full list of active aliases, run `alias`.
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

# from https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load/
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# echo "\n"

prompt_context(){
   prompt_segment green black "%(!.%{%F{yellow}%}.)$USER"
}

prompt_dir() {
    prompt_segment black white ' %1~ '
}

prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
      print -n "%{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
      print -n "%{%k%}"
  fi

  print -n "%{%f%}"
  CURRENT_BG='' 

  printf "\n $";
}

#PROMPT='%{$fg[yellow]%}[%D{%f/%m/%y} %D{%L:%M:%S}] '$PROMPT
#PROMPT='%{$fg[cyan]%}%D{%f/%m/%y} %D{%T} '$PROMPT
tprompt(){
    if test "${PROMPT#*cyan}" != "cyan" 
    then
        PROMPT='%{$fg[cyan]%}%D{%d/%m/%y %H:%M:%S} '$PROMPT
    else 
        # TODO this doesn't work, the idea is to remove the "time pattern" here
        PROMPT=$(echo $PROMPT | awk '{print substr ($0, 35)}')
        # PROMPT= e$PROMPT | cut -c 36-
    fi
}

# to only recommend certain filetypes for sioyek
compdef '_files -g "*.(pdf|epub)"' sioyek

source ~/.oh-my-zsh/custom/plugins/zsh-vimode-visual/zsh-vimode-visual.zsh
source ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey -v

# export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS=""


# bun completions
#[ -s "/Users/chalop/.bun/_bun" ] && source "/Users/chalop/.bun/_bun"

# bun
export BUN_INSTALL="/Users/chalop/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


eval "$(starship init zsh)"
# # pnpm
# export PNPM_HOME="/Users/chalop/Library/pnpm"
# export PATH="$PNPM_HOME:$PATH"
# # pnpm end
#
eval "$(fnm env --use-on-cd)"

# fnm
export PATH=/Users/chalop/.fnm:$PATH
eval "`fnm env`"
eval "$(pyenv init --path)"
export NM_GLOBAL="$(npm root -g)"


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
