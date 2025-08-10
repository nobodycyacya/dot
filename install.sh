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

# [[ General ]]
#
# Vim
ln -snf "$DOT_DIR/vim" "$HOME/.vim"

# Emacs
ln -snf "$DOT_DIR/emacs" "$HOME/.emacs.d"

# Neovim
ln -snf "$DOT_DIR/nvim" "$CONFIG_DIR/nvim"

# Helix
ln -snf "$DOT_DIR/helix" "$CONFIG_DIR/helix"

# JetBrains ideavim
ln -snf "$DOT_DIR/JetBrains/ideavimrc" "$HOME/.ideavimrc"

# WezTerm
ln -snf "$DOT_DIR/wezterm" "$CONFIG_DIR/wezterm"

# Alacritty
ln -snf "$DOT_DIR/alacritty" "$CONFIG_DIR/alacritty"

# Hyper
ln -snf "$DOT_DIR/hyper/hyper.js" "$HOME/.hyper.js"

# Alacritty
ln -snf "$DOT_DIR/kitty" "$CONFIG_DIR/kitty"

# tmux
ln -snf "$DOT_DIR/tmux" "$CONFIG_DIR/tmux"

# kakoune
ln -snf "$DOT_DIR/kak" "$CONFIG_DIR/kak"

# Visual Studio Code
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

# tabby
if [[ "$OS_NAME" == "Darwin" ]]; then
	TABBY_DIR="$HOME/Library/Application Support/tabby"
elif [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	TABBY_DIR="$CONFIG_DIR/tabby"
fi
if [ -n "$TABBY_DIR" ]; then
	mkdir -p "$TABBY_DIR"
	ln -snf "$DOT_DIR/tabby/config.yaml" "$TABBY_DIR/config.yaml"
fi

# ghostty
if [[ "$OS_NAME" == "Darwin" ]]; then
	GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty/"
elif [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	GHOSTTY_DIR="$CONFIG_DIR/ghostty"
fi
if [ -n "$GHOSTTY_DIR" ]; then
	mkdir -p "$GHOSTTY_DIR"
	ln -snf "$DOT_DIR/ghostty/config" "$GHOSTTY_DIR/config"
fi

# [[ Linux or BSD ]]

# awesomeWM
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/awesome" "$CONFIG_DIR/awesome"
fi

# Xresources
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/X11/Xresources" "$HOME/.Xresources"
fi

# dunst
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/dunst" "$CONFIG_DIR/dunst"
fi

# rofi
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/rofi" "$CONFIG_DIR/rofi"
fi

# waybar
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/waybar" "$CONFIG_DIR/waybar"
fi

# hyprland
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/hyprland" "$CONFIG_DIR/hypr"
fi

# qtile
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/qtile" "$CONFIG_DIR/qtile"
fi

# picom
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/picom" "$CONFIG_DIR/picom"
fi

# polybar
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/polybar" "$CONFIG_DIR/polybar"
fi

# conky
if [[ "$OS_NAME" == "Linux" ]] || [[ "$OS_NAME" == *"BSD"* ]]; then
	ln -snf "$DOT_DIR/conky" "$CONFIG_DIR/conky"
fi

# [[ macOS ]]

# aerospace
if [[ "$OS_NAME" == "Darwin" ]]; then
	ln -snf "$DOT_DIR/aerospace" "$CONFIG_DIR/aerospace"
fi

# sketchybar
if [[ "$OS_NAME" == "Darwin" ]]; then
	ln -snf "$DOT_DIR/sketchybar" "$CONFIG_DIR/sketchybar"
fi

# borders
if [[ "$OS_NAME" == "Darwin" ]]; then
	ln -snf "$DOT_DIR/borders" "$CONFIG_DIR/borders"
fi

# yabai
if [[ "$OS_NAME" == "Darwin" ]]; then
	ln -snf "$DOT_DIR/yabai" "$CONFIG_DIR/yabai"
fi

# skhd
if [[ "$OS_NAME" == "Darwin" ]]; then
	ln -snf "$DOT_DIR/skhd" "$CONFIG_DIR/skhd"
fi
