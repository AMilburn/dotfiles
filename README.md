# Dotfiles – Development Environment Setup

This repository contains personal **dotfiles and setup scripts** for configuring a new Mac and bootstrapping modern JavaScript projects (React / Next.js + TypeScript).

The goal of this repo is:
- Fast, repeatable setup on a new machine
- Linting defaults for personal projects

---

## Use Cases

1. **Machine setup**
   - Install tools (Node, pnpm, VS Code, etc.)
   - Install editor extensions
   - Prepare the environment to code

2. **Project setup**
   - Create a new project from scratch
   - Optionally apply personal formatting and linting preferences

---

## Repository Structure

dotfiles/
├─editor/
│   ├── extensions.txt
│   ├── setup-vscode.sh
│   ├── setup-vscode-smart.sh
│   ├── prettier.config.json
│   ├── .eslintrc.json
│   └── vscode/
│       └── settings.json
├── shell/
│   └── zsh-related config files
├── install.sh
├── setup-new-mac.sh
├── new-project-setup.sh
└── README.md

---

## editor/

Contains everything related to VS Code, linting, and formatting.

### `extensions.txt`
A plain-text list of VS Code extensions

---

### `setup-vscode.sh`
Installs VS Code extensions listed in `extensions.txt` and copies any `.json` snippet files from `editor/vscode/snippets/` into the global VS Code snippets directory (`~/Library/Application Support/Code/User/snippets`). If the snippet file already exists in the user's snippets directory (for example, defaults), the script will prompt before overwriting so you can choose to preserve or replace existing snippets.

Safe to run on:
- A new machine
- An existing machine

---

### `setup-vscode-smart.sh`
A VS Code setup script that:

1. Installs VS Code extensions
2. Prompts whether to copy personal configs into the current folder

- **Yes** → copies Prettier, ESLint, and VS Code workspace settings  
- **No** → respects project-defined rules

---

### `prettier.config.json`
Personal prettier formatting defaults

---

### `.eslintrc.json`
Personal ESLint rules for:
- TypeScript
- React

---

### `vscode/settings.json`
VS Code workspace-level settings such as:
- Format on save
- Default formatter
- TypeScript SDK resolution

Linked into projects via `.vscode/settings.json`.

---

## shell/

Shell configuration files (primarily zsh).

Includes things like:
- Aliases
- Environment variables
- Shell behavior

These are symlinked or sourced during machine setup.

---

## setup-new-mac.sh

**Purpose:** Prepare a brand-new Mac for development.

What it does:
- Installs Homebrew (if missing)
- Installs Node via `fnm`
- Installs the latest stable Node version
- Installs `pnpm`
- Installs VS Code
- Runs the smart VS Code setup script

### Usage

```bash
./setup-new-mac.sh

---

## new-project-setup.sh

**Purpose:** Create a brand-new personal project from scratch with my preferred defaults.

### What it does

- Prompts for a project name
- Prompts for project type:
  - Next.js + TypeScript
  - React + TypeScript
- Creates the project using official scaffolding tools
- Copies my personal Prettier configuration
- Copies my personal ESLint configuration
- Links VS Code workspace settings into the project

### Usage

```bash
./new-project-setup.sh
