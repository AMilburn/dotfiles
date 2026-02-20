#!/usr/bin/env bash
set -e

# -------------------------------
# VS CODE EXTENSIONS INSTALLER
# -------------------------------
# Reads ~/dotfiles/editor/extensions.txt
# Installs baseline extensions
# -------------------------------

EXT_FILE="$HOME/dotfiles/editor/extensions.txt"

echo "Installing VS Code extensions from $EXT_FILE..."

while IFS= read -r ext || [[ -n "$ext" ]]; do
    # Ignore empty lines and comments
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

echo "✅ All VS Code extensions installed!"
