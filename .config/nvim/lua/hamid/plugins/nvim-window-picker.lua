return {
	"s1n7ax/nvim-window-picker",
	name = "window-picker",
	event = "VeryLazy",
	version = "2.*",
	config = function()
		require("window-picker").setup({
			-- Optional config
			selection_chars = "ASDFJKL;GHNMWEUIO", -- Easy-to-reach keys
			show_prompt = true,
			filter_rules = {
				include_current_win = false,
				bo = {
					filetype = { "NvimTree", "notify" },
				},
			},
			hint = "floating-big-letter", -- disables the green statusline hinting
			floating_big_letter = {
				-- window picker plugin provides bunch of big letter fonts
				-- fonts will be lazy loaded as they are being requested
				-- additionally, user can pass in a table of fonts in to font
				-- property to use instead

				font = "ansi-shadow", -- ansi-shadow |
			},
		})
	end,
}
