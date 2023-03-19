#!/bin/bash

# smc is a cli included with Stats.app, `brew install stats`
smc='/Applications/Stats.app/Contents/Resources/smc'

RAW_TEMP="$($smc list -t | awk 'FNR == 4 {print $2}')"

ROUNDED_TEMP="$(awk -vtemp="$RAW_TEMP" 'BEGIN { printf("%.0f\n", temp); }')"

DEGREES_SYMBOL=$'\xc2\xb0'C

sketchybar --set $NAME label="$ROUNDED_TEMP$DEGREES_SYMBOL"

if [ $((ROUNDED_TEMP)) -gt 69 ]
then
    sketchybar --set $NAME label.color=0xffbf3f3f
    sketchybar --set $NAME icon.color=0xffbf3f3f
else
    sketchybar --set $NAME label.color=0xffffffff
    sketchybar --set $NAME icon.color=0xffffffff
fi


