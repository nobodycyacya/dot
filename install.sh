#!/usr/bin/env bash

# [[ Strict Mode ]]
set -euo pipefail

# [[ Variables ]]
if echo "$(uname -r)" | grep -qi microsoft; then
	IS_WSL=true
else
	IS_WSL=false
fi
OS_NAME="$(uname -s)"
DOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

# [[ Create ~/.config directory ]]
if [ ! -d "$CONFIG_DIR" ]; then
	mkdir -p "$CONFIG_DIR"
fi

# [[ Vim ]]
ln -snf "$DOT_DIR/vim" "$HOME/.vim"

# [[ Emacs ]]
ln -snf "$DOT_DIR/emacs" "$HOME/.emacs.d"

# [[ Neovim ]]
ln -snf "$DOT_DIR/nvim" "$CONFIG_DIR/nvim"

# [[ Helix ]]
ln -snf "$DOT_DIR/helix" "$CONFIG_DIR/helix"

# [[ JetBrains ideavim ]]
ln -snf "$DOT_DIR/JetBrains/ideavimrc" "$HOME/.ideavimrc"

# [[ WezTerm ]]
ln -snf "$DOT_DIR/wezterm" "$CONFIG_DIR/wezterm"

# [[ kakoune ]]
ln -snf "$DOT_DIR/kak" "$CONFIG_DIR/kak"

# [[ Visual Studio Code ]]
if [[ "$OS_NAME" == "Darwin" ]]; then
	VSCODE_DIR="$HOME/Library/Application Support/Code/User"
elif [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	VSCODE_DIR="$CONFIG_DIR/Code/User"
fi
if [ -n "$VSCODE_DIR" ]; then
	mkdir -p "$VSCODE_DIR"
	ln -snf "$DOT_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"
	ln -snf "$DOT_DIR/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
fi
