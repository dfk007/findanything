#!/usr/bin/env bash
set -e

echo "🔍 Installing FindAnything on your Linux system..."

install_packages() {
    if command -v pacman &>/dev/null; then
        echo "🟢 Arch/Manjaro detected"
        sudo pacman -Sy --needed --noconfirm fd fzf gawk
    elif command -v dnf &>/dev/null; then
        echo "🔵 Fedora/RHEL detected"
        sudo dnf install -y fd-find fzf gawk
    elif command -v apt &>/dev/null; then
        echo "🟠 Ubuntu/Debian detected"
        sudo apt update
        sudo apt install -y fd-find fzf gawk
        echo "✅ Creating symlink: /usr/local/bin/fd -> fdfind"
        sudo ln -sf $(which fdfind) /usr/local/bin/fd
    else
        echo "❌ Unsupported distribution. Please install fd, fzf, gawk manually."
        exit 1
    fi
}

install_packages

echo "⚙️ Setting up Bash function..."
if [ -f ~/.bashrc ]; then
    grep -q "findany()" ~/.bashrc || cat functions/findany.bash >> ~/.bashrc
fi

if command -v fish &>/dev/null; then
    echo "⚙️ Setting up Fish function..."
    mkdir -p ~/.config/fish/functions
    cp functions/findany.fish ~/.config/fish/functions/
fi

sudo cp scripts/findanything_tui.sh /usr/local/bin/findanything
sudo chmod +x /usr/local/bin/findanything

echo "✅ Done! Open a new terminal or run:"
echo "   source ~/.bashrc"
echo "🚀 Then try: findany or findanything"
