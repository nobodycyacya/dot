#!/bin/bash

# [[ Strict Mode ]]
set -euo pipefail

# [[ Variables ]]
OS_NAME="$(uname -s)"
DOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# [[ Create $HOME/.config directory ]]
if [ ! -d "$CONFIG_DIR" ]; then
	mkdir -p "$CONFIG_DIR"
fi

# [[ Vim ]]
ln -snf "$DOT_DIR/vim" "$HOME/.vim"

# [[ Emacs ]]
ln -snf "$DOT_DIR/emacs" "$HOME/.emacs.d"

# [[ Neovim ]]
ln -snf "$DOT_DIR/nvim" "$CONFIG_DIR/nvim"

# [[ WezTerm ]]
ln -snf "$DOT_DIR/wezterm" "$CONFIG_DIR/wezterm"

# [[ Visual Studio Code ]]
if [ "$OS_NAME" == "Darwin" ]; then
	VSCODE_DIR="$HOME/Library/Application Support/Code/User"
	mkdir -p "$VSCODE_DIR"
	ln -snf "$DOT_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
	ln -snf "$DOT_DIR/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
elif [ "$OS_NAME" == "Linux" ] || [[ "$OS_NAME" == *"BSD"* ]]; then
	VSCODE_DIR="$CONFIG_DIR/Code/User"
	mkdir -p "$VSCODE_DIR"
	ln -snf "$DOT_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
	ln -snf "$DOT_DIR/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
fi
