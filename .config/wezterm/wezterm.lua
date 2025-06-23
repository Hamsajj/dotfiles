local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Performance Settings
config.max_fps = 144
config.animation_fps = 60
config.cursor_blink_rate = 250

require("font").configure(config)
require("themes").configure(config)
require("tab").configure(config)
require("keys").configure(config)

return config
