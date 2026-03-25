#!/bin/bash

SESSION="$HOSTNAME"

if tmux has-session -t "$SESSION" 2>/dev/null; then
	tmux attach -t "$SESSION"
else
	tmux new-session -s "$SESSION" -n main
fi
