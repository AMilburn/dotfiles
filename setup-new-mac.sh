#!/usr/bin/env bash
set -e

# ----------------------------------------
# NEW MAC SETUP SCRIPT
# ----------------------------------------
# Prepares a Mac for React/Next.js + TypeScript development
# Installs Homebrew, Node, pnpm, VS Code, and VS Code extensions
# Optional: personal Prettier/ESLint/VS Code configs
# ----------------------------------------

echo "🚀 Starting full new Mac setup..."

# 1️⃣ Install Homebrew if missing
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed"
fi

# Make sure brew is in PATH
eval "$(/opt/homebrew/bin/brew shellenv || /usr/local/bin/brew shellenv)"

# 2️⃣ Install Node via fnm (Fast Node Manager)
if ! command -v fnm &> /dev/null; then
    echo "Installing fnm..."
    brew install fnm
fi

# Initialize fnm in current shell
eval "$(fnm env)"

# Install latest stable Node and set as default
LATEST_NODE=$(fnm list-remote | grep -Eo '^[0-9]+\.[0-9]+\.[0-9]+' | tail -1)
echo "Installing Node $LATEST_NODE..."
fnm install "$LATEST_NODE"
fnm default "$LATEST_NODE"

# 3️⃣ Install pnpm
if ! command -v pnpm &> /dev/null; then
    echo "Installing pnpm..."
    npm install -g pnpm
fi

# 4️⃣ Install VS Code if missing
if ! command -v code &> /dev/null; then
    echo "Installing Visual Studio Code..."
    brew install --cask visual-studio-code
fi

# 5️⃣ Run VS Code smart setup
echo
echo "📦 Setting up VS Code extensions and optional configs..."
"$HOME/dotfiles/editor/setup-vscode-smart.sh"

echo
echo "🎉 New Mac setup complete!"
