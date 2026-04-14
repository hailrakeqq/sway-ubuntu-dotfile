#!/usr/bin/env bash

set -e

echo "👉 Updating system..."
sudo apt update

echo "👉 Installing packages..."
sudo apt install -y zsh git curl wget fonts-jetbrains-mono fzf

# Set zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "👉 Setting zsh as default shell..."
  chsh -s "$(which zsh)"
fi

# Install Oh My Zsh (only if not installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "👉 Installing Oh My Zsh..."
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "👉 Installing plugins..."

# autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# syntax highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Backup old config
if [ -f "$HOME/.zshrc" ]; then
  mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

echo "👉 Creating .zshrc..."

cat > "$HOME/.zshrc" << 'EOF'
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

source $ZSH/oh-my-zsh.sh

# Better history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

# Aliases
alias ll="ls -lah"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"

EOF

echo "✅ Done!"
echo "⚠️ Restart your session or run: exec zsh"
