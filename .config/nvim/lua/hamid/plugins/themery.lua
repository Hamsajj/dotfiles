return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			-- add the config here
			themes = {
				"rose-pine-moon",
				"rose-pine",
				"nord",
				"catppuccin-mocha",
				"catppuccin-macchiato",
				"catppuccin-frappe",
			},
		})
	end,
}
