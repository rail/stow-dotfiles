local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.adjust_window_size_when_changing_font_size = false
config.color_scheme = "Catppuccin Mocha"
config.font_size = 15
config.inactive_pane_hsb = { saturation = 0.8, brightness = 0.8 }
config.scrollback_lines = 10000
config.use_dead_keys = false
config.use_fancy_tab_bar = false
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.window_padding = { left = 5, right = 5, top = 5, bottom = 0.5 }

return config
