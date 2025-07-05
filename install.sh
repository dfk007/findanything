#!/usr/bin/env bash
set -e

echo "🔍 Installing FindAnything on your Linux system..."

install_packages() {
    PKGS=$1
    if command -v pacman &>/dev/null; then
        echo "🟢 Arch/Manjaro detected"
        sudo pacman -Syu --noconfirm $PKGS
    elif command -v dnf &>/dev/null; then
        echo "🔵 Fedora/RHEL detected"
        sudo dnf install -y $PKGS
    elif command -v apt &>/dev/null; then
        echo "🟠 Ubuntu/Debian detected"
        sudo apt update
        sudo apt install -y $PKGS
    else
        echo "❌ Unsupported distro. Install fd, fzf, awk manually."
        exit 1
    fi
}

install_packages "fd fzf awk"

if [ -f ~/.bashrc ]; then
    echo "⚙️ Adding function to Bash"
    grep -q "findany()" ~/.bashrc || cat functions/findany.bash >> ~/.bashrc
fi

if command -v fish &>/dev/null; then
    echo "⚙️ Adding function to Fish"
    mkdir -p ~/.config/fish/functions
    cp functions/findany.fish ~/.config/fish/functions/
fi

sudo cp scripts/findanything_tui.sh /usr/local/bin/findanything
sudo chmod +x /usr/local/bin/findanything

echo "✅ Done! Use 'findany' or 'findanything'"
