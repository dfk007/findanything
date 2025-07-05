findany() {
    local query="$1"
    echo "FOUND Best Match of $query :"
    fd "$query" / --hidden --type f --type d --follow | head -n 10 | nl
    echo "----------------------------------"
}