#!/usr/bin/env bash
set -e

# ----------------------------
# NEW MAC NODE ENV INSTALL SCRIPT
# ----------------------------
# This script sets up:
# 1. Homebrew
# 2. Git
# 3. fnm (Fast Node Manager)
# 4. Latest Node LTS
# 5. pnpm
# 6. Shell config (~/.zshrc) to make everything work immediately
# ----------------------------

echo "Step 1: Installing Homebrew if missing..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew already installed"
fi

echo "Step 2: Installing Git, fnm, and pnpm..."
brew install git fnm pnpm

echo "Step 3: Configuring shell (~/.zshrc)..."
ZSHRC="$HOME/.zshrc"

# Add fnm to shell if not already present
if ! grep -q "fnm env" "$ZSHRC"; then
  echo 'eval "$(fnm env)"' >> "$ZSHRC"
fi

# Add Homebrew PATH if not already present
if ! grep -q "brew shellenv" "$ZSHRC"; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$ZSHRC"
fi

# Reload shell config
source "$ZSHRC"

echo "Step 4: Installing Node 20 via fnm..."
fnm install 20
fnm default 20

echo "Step 5: Verifying installations..."
echo "Git: $(git --version)"
echo "Node: $(node -v)"
echo "pnpm: $(pnpm -v)"
echo "fnm: $(fnm --version)"

echo "✅ All done! Your Node + pnpm environment is ready."
