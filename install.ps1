# [[ Strict Mode ]]
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# [[ Variables ]]
$CONFIG_DIR = Join-Path $env:USERPROFILE ".config"
$DOT_DIR = $PSScriptRoot

# [[ Create ~/.config directory ]]
if (-not (Test-Path -Path $CONFIG_DIR)) {
	New-Item -Path $CONFIG_DIR -ItemType Directory -Force
}

# [[ Vim ]]
$VIM_DIR = Join-Path $env:USERPROFILE "vimfiles"
$VIM_DOT = Join-Path $DOT_DIR "vim"
if (-not (Test-Path -Path $VIM_DIR)) {
	New-Item -ItemType SymbolicLink -Path $VIM_DIR -Target $VIM_DOT -ErrorAction Stop
} else {
	Remove-Item -Path $VIM_DIR -Recurse -Force
	New-Item -ItemType SymbolicLink -Path $VIM_DIR -Target $VIM_DOT -ErrorAction Stop
}

# [[ Neovim ]]
$NEOVIM_DIR = Join-Path $env:LOCALAPPDATA "nvim"
$NEOVIM_DOT = Join-Path $DOT_DIR "nvim"
if (-not (Test-Path -Path $NEOVIM_DIR)) {
	New-Item -ItemType SymbolicLink -Path $NEOVIM_DIR -Target $NEOVIM_DOT -ErrorAction Stop
} else {
	Remove-Item -Path $NEOVIM_DIR -Recurse -Force
	New-Item -ItemType SymbolicLink -Path $NEOVIM_DIR -Target $NEOVIM_DOT -ErrorAction Stop
}

# [[ Emacs ]]
$EMACS_DIR = Join-Path $env:USERPROFILE ".emacs.d"
$EMACS_DOT = Join-Path $DOT_DIR "emacs"
if (-not (Test-Path -Path $EMACS_DIR)) {
	New-Item -ItemType SymbolicLink -Path $EMACS_DIR -Target $EMACS_DOT -ErrorAction Stop
} else {
	Remove-Item -Path $EMACS_DIR -Recurse -Force
	New-Item -ItemType SymbolicLink -Path $EMACS_DIR -Target $EMACS_DOT -ErrorAction Stop
}

# [[ Helix ]]
$HELIX_DIR = Join-Path $env:APPDATA "helix"
$HELIX_DOT = Join-Path $DOT_DIR "helix"
if (-not (Test-Path -Path $HELIX_DIR)) {
	New-Item -ItemType SymbolicLink -Path $HELIX_DIR -Target $HELIX_DOT -ErrorAction Stop
} else {
	Remove-Item -Path $HELIX_DIR -Recurse -Force
	New-Item -ItemType SymbolicLink -Path $HELIX_DIR -Target $HELIX_DOT -ErrorAction Stop
}

# [[ JetBrains ideavim ]]
$IDEAVIM_VIMRC = Join-Path $env:USERPROFILE ".ideavimrc"
$IDEAVIM_DOT_VIMRC = Join-Path $DOT_DIR "JetBrains\ideavimrc"
if (Test-Path -Path $IDEAVIM_VIMRC) {
	Remove-Item -Path $IDEAVIM_VIMRC -Force -ErrorAction SilentlyContinue
	New-Item -ItemType SymbolicLink -Path $IDEAVIM_VIMRC -Target $IDEAVIM_DOT_VIMRC -ErrorAction Stop
} else {
	New-Item -ItemType SymbolicLink -Path $IDEAVIM_VIMRC -Target $IDEAVIM_DOT_VIMRC -ErrorAction Stop
}

# [[ WezTerm ]]
$WEZTERM_DIR = Join-Path $CONFIG_DIR "wezterm"
$WEZTERM_DOT = Join-Path $DOT_DIR "wezterm"
if (-not (Test-Path -Path $WEZTERM_DIR)) {
	New-Item -ItemType SymbolicLink -Path $WEZTERM_DIR -Target $WEZTERM_DOT -ErrorAction Stop
} else {
	Remove-Item -Path $WEZTERM_DIR -Recurse -Force
	New-Item -ItemType SymbolicLink -Path $WEZTERM_DIR -Target $WEZTERM_DOT -ErrorAction Stop
}

# [[ Alacritty ]]
$ALACRITTY_DIR = Join-Path $env:APPDATA "alacritty"
$ALACRITTY_DOT = Join-Path $DOT_DIR "alacritty"
if (-not (Test-Path -Path $ALACRITTY_DIR)) {
	New-Item -ItemType SymbolicLink -Path $ALACRITTY_DIR -Target $ALACRITTY_DOT -ErrorAction Stop
} else {
	Remove-Item -Path $ALACRITTY_DIR -Recurse -Force
	New-Item -ItemType SymbolicLink -Path $ALACRITTY_DIR -Target $ALACRITTY_DOT -ErrorAction Stop
}

# [[ Visual Studio Code ]]
$VSCODE_USER_DIR = Join-Path $env:APPDATA "Code\User"
$VSCODE_SETTINGS = Join-Path $VSCODE_USER_DIR "settings.json"
$VSCODE_KEYBINDINGS = Join-Path $VSCODE_USER_DIR "keybindings.json"
$VSCODE_DOT_SETTINGS = Join-Path $DOT_DIR "vscode\settings.json"
$VSCODE_DOT_KEYBINDINGS = Join-Path $DOT_DIR "vscode\keybindings.json"
if (-not (Test-Path -Path $VSCODE_USER_DIR -PathType Container)) {
	New-Item -Path $VSCODE_USER_DIR -ItemType Directory -Force
}
if (Test-Path -Path $VSCODE_SETTINGS) {
	Remove-Item -Path $VSCODE_SETTINGS -Force -ErrorAction SilentlyContinue
	New-Item -ItemType SymbolicLink -Path $VSCODE_SETTINGS -Target $VSCODE_DOT_SETTINGS -ErrorAction Stop
} else {
	New-Item -ItemType SymbolicLink -Path $VSCODE_SETTINGS -Target $VSCODE_DOT_SETTINGS -ErrorAction Stop
}
if (Test-Path -Path $VSCODE_KEYBINDINGS) {
	Remove-Item -Path $VSCODE_KEYBINDINGS -Force -ErrorAction SilentlyContinue
	New-Item -ItemType SymbolicLink -Path $VSCODE_KEYBINDINGS -Target $VSCODE_DOT_KEYBINDINGS -ErrorAction Stop
} else {
	New-Item -ItemType SymbolicLink -Path $VSCODE_KEYBINDINGS -Target $VSCODE_DOT_KEYBINDINGS -ErrorAction Stop
}

# [[ Windows Terminal ]]
$WINDOWSTERMINAL_DIR = Join-Path $env:LOCALAPPDATA "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$WINDOWSTERMINAL_SETTINGS = Join-Path $WINDOWSTERMINAL_DIR "settings.json"
$WINDOWSTERMINAL_DOT_SETTINGS = Join-Path $DOT_DIR "WindowsTerminal\settings.json"
if (-not (Test-Path -Path $WINDOWSTERMINAL_DIR -PathType Container)) {
	New-Item -Path $WINDOWSTERMINAL_DIR -ItemType Directory -Force
}
if (Test-Path -Path $WINDOWSTERMINAL_SETTINGS) {
	Remove-Item -Path $WINDOWSTERMINAL_SETTINGS -Force -ErrorAction SilentlyContinue
	New-Item -ItemType SymbolicLink -Path $WINDOWSTERMINAL_SETTINGS -Target $WINDOWSTERMINAL_DOT_SETTINGS -ErrorAction Stop
} else {
	New-Item -ItemType SymbolicLink -Path $WINDOWSTERMINAL_SETTINGS -Target $WINDOWSTERMINAL_DOT_SETTINGS -ErrorAction Stop
}

# [[ glzr ]]
$GLZR_DIR = Join-Path $HOME ".glzr"
$GLZR_DOT = Join-Path $DOT_DIR "glzr"
if (-not (Test-Path -Path $GLZR_DIR)) {
	New-Item -ItemType SymbolicLink -Path $GLZR_DIR -Target $GLZR_DOT -ErrorAction Stop
} else {
	Remove-Item -Path $GLZR_DIR -Recurse -Force
	New-Item -ItemType SymbolicLink -Path $GLZR_DIR -Target $GLZR_DOT -ErrorAction Stop
}
