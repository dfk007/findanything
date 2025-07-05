function findany
    fd --hidden --type f --type d --follow / | fzf --prompt="FindAnything > " --height=40%
end
