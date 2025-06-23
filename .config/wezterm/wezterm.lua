local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("configs").configure(config)

return config
