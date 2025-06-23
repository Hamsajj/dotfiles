local wezterm = require("wezterm")

local M = {}

function M.configure(config)
	config.enable_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
	config.show_new_tab_button_in_tab_bar = true
	config.show_tab_index_in_tab_bar = false
	config.show_tabs_in_tab_bar = true
	config.switch_to_last_active_tab_when_closing_tab = false
	config.tab_and_split_indices_are_zero_based = false
	config.tab_bar_at_bottom = true
	config.tab_max_width = 25
	config.use_fancy_tab_bar = false

	config.colors.tab_bar = {
		background = config.window_background_image and "rgba(0, 0, 0, 0)" or config.transparent_bg,
		new_tab = {
			fg_color = config.colors.background,
			bg_color = config.colors.brights[6],
		},
		new_tab_hover = {
			fg_color = config.colors.background,
			bg_color = config.colors.foreground,
		},
	}

	wezterm.on("format-tab-title", function(tab, _, _, _, hover)
		local background = config.colors.brights[1]
		local foreground = config.colors.foreground

		if tab.is_active then
			background = config.colors.brights[7]
			foreground = config.colors.background
		elseif hover then
			background = config.colors.brights[8]
			foreground = config.colors.background
		end

		local index = tostring(tab.tab_index + 1)
		local title = tab.active_pane.title or ""

		return {
			{ Foreground = { Color = background } },
			{ Text = "█" },
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = index .. ": " .. title },
			{ Foreground = { Color = background } },
			{ Text = "█" },
		}
	end)
end

return M
