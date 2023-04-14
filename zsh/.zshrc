# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Path to your oh-my-zsh installation.
export ZSH="/Users/chalop/.oh-my-zsh"
export TILE_PATH="$HOME/scripts/tile-manager"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode zsh-vimode-visual zsh-syntax-highlighting)
# To lazy load NVM, only toggle when needed
# plugins+=(zsh-nvm)
source $ZSH/oh-my-zsh.sh

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
alias vim="lvim"
alias v="lvim"
alias es="expo start"
alias ti="tree -I node_modules"
alias ls="lsd"
alias rr="ranger"
alias tree="lsd --tree"
alias rc="vim ~/.zshrc"
alias soce="source ~/.zshrc"
alias yt-mp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"'
alias h-search="history | grep"
alias clear="echo -n -e \"\e[2J\e[3J\e[1;1H\""
alias e="exit"
alias gg="lazygit"
alias tm="tmux"

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

# bun completions
#[ -s "/Users/chalop/.bun/_bun" ] && source "/Users/chalop/.bun/_bun"

# bun
export BUN_INSTALL="/Users/chalop/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# # pnpm
# export PNPM_HOME="/Users/chalop/Library/pnpm"
# export PATH="$PNPM_HOME:$PATH"
# # pnpm end
#
eval "$(fnm env --use-on-cd)"

# fnm
export PATH=/Users/chalop/.fnm:$PATH
eval "`fnm env`"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
