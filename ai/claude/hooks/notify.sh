#!/bin/bash
# iTerm2 notification via OSC 9 escape sequence.
# Works in tmux (local or SSH) by writing directly to client TTYs.

INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // ""')
TITLE=$(echo "$INPUT" | jq -r '.title // "Claude Code"')
MESSAGE=$(echo "$INPUT" | jq -r '.message // ""')

# Build message based on event type
case "$EVENT" in
  Stop)          MESSAGE="Claude finished" ;;
  Notification)  ;; # use message from input as-is
  *)             MESSAGE="${EVENT}: ${MESSAGE}" ;;
esac

OSC="\e]9;${MESSAGE}\a"

if [ -n "$TMUX" ]; then
  # Write directly to all tmux client TTYs so iTerm2 sees the escape
  SESSION=$(tmux display -p '#{session_name}' 2>/dev/null)
  if [ -n "$SESSION" ]; then
    tmux list-clients -t "$SESSION" -F '#{client_tty}' 2>/dev/null | while read -r TTY; do
      [ -n "$TTY" ] && printf "$OSC" > "$TTY"
    done
  fi
else
  # Write directly to the terminal
  printf "$OSC" > /dev/tty
fi

exit 0
