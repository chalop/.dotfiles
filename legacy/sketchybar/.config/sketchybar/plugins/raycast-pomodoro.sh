#!/bin/bash

raw_json=$(python3 $HOME/Dev/m/simple-pomodoro/main.py) 

TYPE=$(jq -r '.type' <<< $raw_json)
TIME=$(jq -r '.time_remaining' <<< $raw_json)

if [ -n "$TYPE" ]; then
    if [ $TYPE == "focus" ]; then
        symbol="🍅"
    elif [ "$TYPE" == "short-break" ]; then
        symbol="☕️"
    elif [ "$TYPE" == "long-break" ]; then
        symbol="🛏️"
    else
        symbol=""
    fi
fi

sketchybar --set $NAME label="$symbol $TIME"
