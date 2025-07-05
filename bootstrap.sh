#!/usr/bin/env bash
set -e
echo "📥 Cloning findanything repository..."
git clone https://github.com/dfk007/findanything.git ~/findanything-tmp
cd ~/findanything-tmp
echo "🚀 Running installer..."
bash install.sh
cd ~
rm -rf ~/findanything-tmp
echo "✅ FindAnything setup complete!"
