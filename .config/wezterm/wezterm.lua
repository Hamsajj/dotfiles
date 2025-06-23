local wezterm = require("wezterm")
local config = wezterm.config_builder()


config.color_scheme = 'Dracula'

config.font = wezterm.font({
	family = "JetBrains Mono",
	weight = "Medium",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" }, -- disable ligatures
})
config.font_size = 12.0
config.line_height = 1.2

-- (here will be added actual configuration)

return config
