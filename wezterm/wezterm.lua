local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on("gui-startup", function()
	local tab, pane, window = wezterm.mux.spawn_window{}
	window:gui_window():maximize()
end)

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.font_size = 9.25
	config.default_prog = { "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" }
	config.window_background_opacity = 0.98
elseif wezterm.target_triple == "x86_64-apple-darwin" then
	config.font_size = 13.0
	config.default_prog = { "/bin/zsh", "-l" }
	config.window_background_opacity = 0.98
elseif wezterm.target_triple == "aarch64-apple-darwin" then
	config.font_size = 13.0
	config.default_prog = { "/bin/zsh", "-l" }
	config.window_background_opacity = 0.98
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.font_size = 12.0
	config.default_prog = { "/usr/bin/bash", "-l" }
	config.window_background_opacity = 1.0
end

config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })
config.cell_width = 0.9
config.front_end = "OpenGL"
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.0
config.window_close_confirmation = "NeverPrompt"

return config
