local M = {}

function M.configure(config)
	local opacity = 0.98

	-- Color Configuration
	config.colors = require("colors.dracula")
	config.force_reverse_video_cursor = true

	-- Window Configuration

	-- Cursor
	config.cursor_blink_ease_in = "EaseIn"
	config.cursor_blink_ease_out = "EaseOut"
	config.cursor_blink_rate = 500
	config.default_cursor_style = "BlinkingUnderline"
	config.cursor_thickness = 1
	config.force_reverse_video_cursor = true

	config.enable_scroll_bar = true

	config.hide_mouse_cursor_when_typing = true

	config.window_background_opacity = opacity
	config.window_padding = { left = 1, right = 1, top = 1, bottom = 1 }
	config.integrated_title_button_alignment = "Right"
	config.integrated_title_button_style = "Windows"
	config.integrated_title_buttons = { "Maximize", "Close" }
end

return M
