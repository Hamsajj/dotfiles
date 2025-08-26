local wezterm = require("wezterm")
local config = wezterm.config_builder()
local mux = wezterm.mux

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_domain = "WSL:Ubuntu-22.04"
end

wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

require("configs").configure(config)

return config
