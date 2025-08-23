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
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
        -- Windows laptop resolution is terrible, compensate with smaller font size
		config.font_size = 9
	else
		config.font_size = 12
	end
	config.line_height = 1.1
end

return M
