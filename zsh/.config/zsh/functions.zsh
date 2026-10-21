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
