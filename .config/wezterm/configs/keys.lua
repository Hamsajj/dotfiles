local wezterm = require("wezterm")
local act = wezterm.action
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local M = {}

function M.configure(config)
	config.leader = { key = "s", mods = "CMD", timeout_milliseconds = 1000 }
	config.key_tables = {
		resize_pane = {
			{ key = "h", action = act.AdjustPaneSize({ "Left", 2 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 2 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 2 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 2 }) },
			{ key = "h", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 2 }) },
			{ key = "j", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 2 }) },
			{ key = "k", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 2 }) },
			{ key = "l", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 2 }) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
	}
	config.keys = {
		{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.ToggleFullScreen },
		{ key = "v", mods = "CTRL", action = wezterm.action({ PasteFrom = "Clipboard" }) },
		{ key = "f", mods = "CTRL", action = workspace_switcher.switch_workspace() },
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action_callback(function(win, pane)
				resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
				resurrect.window_state.save_window_action()
			end),
		},
		{
			key = "x",
			mods = "LEADER",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
					resurrect.state_manager.delete_state(id)
				end, {
					title = "Delete State",
					description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
					fuzzy_description = "Search State to Delete: ",
					is_fuzzy = true,
				})
			end),
		},
		{
			key = "r",
			mods = "LEADER",
			action = wezterm.action_callback(function(win, pane)
				resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
					local type = string.match(id, "^([^/]+)") -- match before '/'
					id = string.match(id, "([^/]+)$") -- match after '/'
					id = string.match(id, "(.+)%..+$") -- remove file extention
					local opts = {
						relative = true,
						restore_text = true,
						on_pane_restore = resurrect.tab_state.default_on_pane_restore,
						close_open_tabs = true,
					}
					if type == "workspace" then
						local state = resurrect.state_manager.load_state(id, "workspace")
						resurrect.workspace_state.restore_workspace(state, opts)
					elseif type == "window" then
						local state = resurrect.state_manager.load_state(id, "window")
						resurrect.window_state.restore_window(pane:window(), state, opts)
					elseif type == "tab" then
						local state = resurrect.state_manager.load_state(id, "tab")
						resurrect.tab_state.restore_tab(pane:tab(), state, opts)
					end
				end)
			end),
		},
		{
			key = "q",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Down",
				size = { Percent = 40 },
			}),
		},
		{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
		{ key = "n", mods = "LEADER", action = act.ActivatePaneDirection("Next") },
		{ key = "Tab", mods = "CTRL", action = act.ActivatePaneDirection("Next") },
		{ key = "e", mods = "LEADER", action = act.PaneSelect({ mode = "Activate" }) },
		{ key = "w", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
		{
			key = "1",
			mods = "LEADER",
			action = wezterm.action_callback(function(_, pane)
				pane:move_to_new_tab()
			end),
		},
		{
			key = "z",
			mods = "LEADER",
			action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},
		{ key = "Enter", mods = "LEADER", action = act.TogglePaneZoomState },
		{
			key = "d",
			mods = "LEADER",
			action = wezterm.action.SplitPane({
				direction = "Right",
				size = { Percent = 40 },
			}),
		},
		-- Set tab title
		{
			key = "E",
			mods = "CTRL|SHIFT",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter new name for the tab" },
				}),
				action = wezterm.action_callback(function(window, _, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		-- Create new tab with a name
		{
			key = "N",
			mods = "CTRL|SHIFT",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	}
end

return M
