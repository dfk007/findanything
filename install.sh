#!/usr/bin/env bash
set -e

echo "🔍 Installing FindAnything on your Linux system..."

install_packages_arch() {
    echo "🟢 Arch/Manjaro detected"
    echo "   Checking packages: fd fzf gawk"
    missing=""
    for pkg in fd fzf gawk; do
        if ! pacman -Qq $pkg &>/dev/null; then
            missing="$missing $pkg"
        fi
    done
    if [ -z "$missing" ]; then
        echo "✅ All packages already installed."
    else
        echo "⬇️ Installing missing packages: $missing"
        sudo pacman -S --needed --noconfirm $missing ||             (echo "⚠️ If conflicts occur, run: sudo pacman -S --needed --overwrite='*' $missing"; exit 1)
    fi
}

install_packages_ubuntu() {
    echo "🟠 Ubuntu/Debian detected"
    echo "   Checking packages: fd-find fzf gawk"
    [ -x /usr/local/bin/fd ] && found_fd=true || found_fd=false
    dpkg -s fzf gawk &>/dev/null && found_others=true || found_others=false
    if $found_fd && $found_others; then
        echo "✅ All packages already installed."
    else
        echo "⬇️ Installing missing packages"
        sudo apt update
        sudo apt install -y fd-find fzf gawk
        echo "✅ Creating symlink: /usr/local/bin/fd -> fdfind"
        sudo ln -sf $(which fdfind) /usr/local/bin/fd
    fi
}

install_packages_fedora() {
    echo "🔵 Fedora/RHEL detected"
    echo "   Checking packages: fd-find fzf gawk"
    missing=""
    for pkg in fd-find fzf gawk; do
        if ! rpm -q $pkg &>/dev/null; then
            missing="$missing $pkg"
        fi
    done
    if [ -z "$missing" ]; then
        echo "✅ All packages already installed."
    else
        echo "⬇️ Installing missing packages: $missing"
        sudo dnf install -y $missing
    fi
}

if command -v pacman &>/dev/null; then
    install_packages_arch
elif command -v apt &>/dev/null; then
    install_packages_ubuntu
elif command -v dnf &>/dev/null; then
    install_packages_fedora
else
    echo "❌ Unsupported Linux distribution. Please install fd, fzf, gawk manually."
    exit 1
fi

echo "⚙️ Setting up Bash function..."
if [ -f ~/.bashrc ]; then
    grep -q "findany()" ~/.bashrc || cat functions/findany.bash >> ~/.bashrc
fi

if command -v fish &>/dev/null; then
    echo "⚙️ Setting up Fish function..."
    mkdir -p ~/.config/fish/functions
    cp functions/findany.fish ~/.config/fish/functions/
fi

echo "⚙️ Installing /usr/local/bin/findanything"
sudo cp scripts/findanything_tui.sh /usr/local/bin/findanything
sudo chmod +x /usr/local/bin/findanything

echo "✅ Done!"
echo "💡 Open a new terminal or run: source ~/.bashrc"
echo "🚀 Then try: findany or findanything"
