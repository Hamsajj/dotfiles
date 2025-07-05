local wezterm = require("wezterm")

local M = {}

function M.configure(config)
	config.keys = {
		{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
		{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{
			key = "q",
			mods = "SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 30 },
			}),
		},
		{
			key = "d",
			mods = "SHIFT",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 40 },
			}),
		},
	}
end

return M
