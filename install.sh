#!/bin/bash

set -euo pipefail

# [[ Variables ]]
OS_NAME="$(uname -s)"
DOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# [[ Create $HOME/.config directory ]]
if [ ! -d "$CONFIG_DIR" ]; then
	mkdir -p "$CONFIG_DIR"
fi

# [[ vim ]]
ln -snf "$DOT_DIR/vim" "$HOME/.vim"

# [[ Neovim ]]
ln -snf "$DOT_DIR/nvim" "$CONFIG_DIR/nvim"

# [[ Emacs ]]
ln -snf "$DOT_DIR/emacs" "$HOME/.emacs.d"

# [[ WezTerm ]]
ln -snf "$DOT_DIR/wezterm" "$CONFIG_DIR/wezterm"

# [[ Visual Studio Code ]]
if [ "$OS_NAME" == "Darwin" ]; then
	mkdir -p "$HOME/Library/Application Support/Code/User"
	ln -snf "$DOT_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
	ln -snf "$DOT_DIR/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User/keybindings.json"
elif [ "$OS_NAME" == "Linux" ] || [[ "$OS_NAME" == *"BSD"* ]]; then
	mkdir -p "$CONFIG_DIR/Code/User"
	ln -snf "$DOT_DIR/vscode/settings.json" "$CONFIG_DIR/Code/User/settings.json"
	ln -snf "$DOT_DIR/vscode/keybindings.json" "$CONFIG_DIR/Code/User/keybindings.json"
fi
