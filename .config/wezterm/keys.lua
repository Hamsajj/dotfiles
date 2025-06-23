local wezterm = require("wezterm")

local M = {}

function M.configure(config)
	config.keys = {
		{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
		{ key = "t", mods = "CTRL", action = wezterm.action.SpawnTab("DefaultDomain") },
		{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	}
end

return M
