#!/bin/sh
# focusing the previous workspace fires workspace.focused, which swaps current and previous
previous=$(cat "$HERDR_PLUGIN_STATE_DIR/previous" 2> /dev/null)
[ -n "$previous" ] || exit 0
exec "${HERDR_BIN_PATH:-herdr}" workspace focus "$previous"
