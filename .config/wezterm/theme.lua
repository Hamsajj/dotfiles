local M = {}

function M.configure(config)
	local opacity = 0.98

	-- Color Configuration
	config.colors = require("colors.dracula")
	-- config.color_scheme = "Dracula (base16)"
	config.force_reverse_video_cursor = true

	-- Window Configuration
	config.initial_rows = 90
	config.initial_cols = 180
	config.window_decorations = "TITLE|RESIZE"
	config.window_background_opacity = opacity
end

return M
