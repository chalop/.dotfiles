#!/bin/sh
# remember the focused workspace and the one focused before it
state="$HERDR_PLUGIN_STATE_DIR"
mkdir -p "$state"
id=$(printf '%s' "$HERDR_PLUGIN_EVENT_JSON" | jq -r '[.. | .workspace_id? | strings][0] // empty')
[ -n "$id" ] || exit 0
current=$(cat "$state/current" 2> /dev/null)
[ "$id" = "$current" ] && exit 0
[ -n "$current" ] && printf '%s' "$current" > "$state/previous"
printf '%s' "$id" > "$state/current"
