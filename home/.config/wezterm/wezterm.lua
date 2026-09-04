local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "tokyonight_moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13.0

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- dim panes that don't have focus
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.6,
}

config.scrollback_lines = 5000

return config
