#!/bin/sh
# ZSH_EDIT_FILE holds the command line, the zsh widget waits for the .done marker
trap 'touch "$ZSH_EDIT_FILE.done"' EXIT HUP TERM
${EDITOR:-nvim} -c 'set ft=zsh' "$ZSH_EDIT_FILE"
