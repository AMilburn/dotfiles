#!/usr/bin/env bash
set -e

# ----------------------------------------
# VS CODE SETUP SCRIPT
# ----------------------------------------
# Installs extensions from extensions.txt
# Optionally copies personal Prettier/ESLint/VSCode settings
# ----------------------------------------

EXT_FILE="$HOME/dotfiles/editor/extensions.txt"

echo "Installing VS Code extensions from $EXT_FILE..."
while IFS= read -r ext || [[ -n "$ext" ]]; do
    # Skip empty lines or comments
    if [[ -z "$ext" || "$ext" =~ ^# ]]; then
        continue
    fi
    echo "Installing $ext..."
    if code --install-extension "$ext"; then
        echo "✅ Installed $ext"
    else
        echo "⚠ Failed to install $ext, skipping"
    fi
done < "$EXT_FILE"

# Ask user if they want to copy personal configs
echo
read -p "Do you want to copy your personal Prettier, ESLint, and VS Code configs into this folder? [y/N]: " copy_configs

if [[ "$copy_configs" =~ ^[Yy]$ ]]; then
    echo "Copying personal configs..."
    cp "$HOME/dotfiles/editor/prettier.config.json" ./prettier.config.json
    cp "$HOME/dotfiles/editor/.eslintrc.json" ./.eslintrc.json

    mkdir -p .vscode
    ln -sf "$HOME/dotfiles/editor/vscode/settings.json" .vscode/settings.json

    echo "✅ Personal configs copied!"
else
    echo "Skipping copying configs. Using project-defined rules."
fi

echo
echo "🎉 VS Code setup complete!"
