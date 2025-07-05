#!/usr/bin/env bash
echo "Launching FindAnything TUI..."

QUERY="$1"

fd "${QUERY:-.}" / --hidden --type f --type d --follow | \
fzf --prompt="FindAnything > " --height=40% --multi --preview="head -n 50 {}"
