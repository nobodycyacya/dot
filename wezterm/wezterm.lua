local wezterm = require("wezterm")
local config = wezterm.config_builder()

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.font_size = 10
  config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold', italic = false })
  config.default_prog = { 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe' }
elseif wezterm.target_triple == "aarch64-apple-darwin"  then
  config.font_size = 11
  config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold', italic = false })
  config.default_prog = { '/usr/bin/zsh', '-l' }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu"  then
  config.font_size = 12
  config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Bold', italic = false })
  config.default_prog = { '/usr/bin/bash', '-l' }
end

config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.1
config.color_scheme = 'DoomOne'
config.window_padding = {
  left = 12,
  right = 12,
  top = 12,
  bottom = 12
}

return config
