#!/usr/bin/env bash

echo "Launching FindAnything TUI..."

fd . / \
  --hidden \
  --exclude ".git" \
  --color always \
  | fzf --preview '
    if file --mime-type {} | grep -q text; then
      head -n 50 {}
    else
      echo "[Binary file: {}]"
    fi
  ' --preview-window=right:60%:wrap \
    --prompt "FindAnything > "
