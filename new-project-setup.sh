#!/usr/bin/env bash
set -e

# ----------------------------------------
# NEW PERSONAL PROJECT SETUP
# ----------------------------------------
# Creates a Next.js or React project with TypeScript
# Copies personal Prettier/ESLint/VS Code configs
# ----------------------------------------

# Ask for project name
read -p "Enter project name: " PROJECT_NAME

# Ask for project type
echo "Select project type:"
echo "1) Next.js (recommended)"
echo "2) React (create-react-app)"
read -p "Enter 1 or 2: " PROJECT_TYPE

# Create project
if [[ "$PROJECT_TYPE" == "1" ]]; then
    pnpm create next-app "$PROJECT_NAME" --typescript
elif [[ "$PROJECT_TYPE" == "2" ]]; then
    pnpm create react-app "$PROJECT_NAME" --template typescript
else
    echo "Invalid option. Exiting."
    exit 1
fi

cd "$PROJECT_NAME"

# Copy personal configs
echo "Copying personal Prettier and ESLint configs..."
cp "$HOME/dotfiles/editor/prettier.config.json" ./prettier.config.json
cp "$HOME/dotfiles/editor/.eslintrc.json" ./.eslintrc.json

# Link VS Code settings
mkdir -p .vscode
ln -sf "$HOME/dotfiles/editor/vscode/settings.json" .vscode/settings.json

echo "✅ Project '$PROJECT_NAME' created with personal configs!"
