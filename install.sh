#!/usr/bin/env bash

set -e

echo "🚀 Installing Sway dotfiles stack..."

# =========================
# 📦 Packages
# =========================
sudo apt update

sudo apt install -y \
  sway \
  wofi \
  waybar \
  grim \
  slurp \
  wl-clipboard \
  fonts-font-awesome \
  fonts-jetbrains-mono

echo "✅ Packages installed"

# =========================
#    Install zsh
# =========================

#chmod +x scripts/install_zsh.zip 
#./scripts/install_zsh.zip

# =========================
# 📁 Config paths
# =========================
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "📂 Dotfiles directory: $DIR"

# =========================
# 🧠 Sway config
# =========================
mkdir -p ~/.config/sway
cp -r "$DIR/sway/"* ~/.config/sway/

# =========================
# 📊 Waybar config
# =========================
mkdir -p ~/.config/waybar
if [ -d "$DIR/waybar" ]; then
  cp -r "$DIR/waybar/"* ~/.config/waybar/
fi

# =========================
# 🪟 Wofi config
# =========================
mkdir -p ~/.config/wofi
if [ -d "$DIR/wofi" ]; then
  cp -r "$DIR/wofi/"* ~/.config/wofi/
fi

# =========================
# 🪟 Mako config
# =========================
mkdir -p ~/.config/mako
if [ -d "$DIR/mako" ]; then
  cp -r "$DIR/mako/"* ~/.config/mako/
fi


# =========================
# 🖥 Alacritty config
# =========================
mkdir -p ~/.config/alacritty
if [ -d "$DIR/alacritty" ]; then
  cp -r "$DIR/alacritty/"* ~/.config/alacritty/
fi

# =========================
# ⚙️ Scripts
# =========================

echo "🎉 Done!"
echo "👉 Log out and start Sway to apply changes"
