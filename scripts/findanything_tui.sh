#!/usr/bin/env bash
echo "Launching FindAnything TUI..."
fd --hidden --type f --type d --follow / | fzf --prompt="FindAnything > " --height=40%
