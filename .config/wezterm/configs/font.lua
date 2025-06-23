local wezterm = require("wezterm")

local M = {}

function M.configure(config)
	local emoji_font = "Segoe UI Emoji"
	config.font = wezterm.font_with_fallback({
		{
			family = "JetBrainsMono Nerd Font",
			weight = "Medium",
		},
		emoji_font,
	})
	config.font_size = 12
	config.line_height = 1.15
end

return M
