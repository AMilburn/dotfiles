#!/usr/bin/env bash
set -e

# ----------------------------------------
# VS CODE SETUP SCRIPT
# ----------------------------------------
# Installs extensions from extensions.txt
# Copies all snippets from vscode/snippets/
# ----------------------------------------

# ----------------------------------------
# Install extensions
# ----------------------------------------
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

# ----------------------------------------
# Copy personal snippets
# ----------------------------------------
SNIPPETS_SRC="$HOME/dotfiles/editor/vscode/snippets"
SNIPPETS_DIR="$HOME/Library/Application Support/Code/User/snippets"
mkdir -p "$SNIPPETS_DIR"

echo "Copying VS Code snippets from $SNIPPETS_SRC..."

for snippet_file in "$SNIPPETS_SRC"/*.json; do
    # Skip if no .json files exist
    [[ -e "$snippet_file" ]] || continue

    snippet_name=$(basename "$snippet_file" .json)
    target_file="$SNIPPETS_DIR/$(basename "$snippet_file")"

    if [[ -e "$target_file" ]]; then
        echo "⚠ Snippet '$snippet_name' already exists in VS Code. Skipping copy."
    else
        cp "$snippet_file" "$target_file"
        echo "✅ Copied snippet '$snippet_name' to VS Code."
    fi
done

echo "🎉 VS Code setup complete!"
