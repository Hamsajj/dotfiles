return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<C-\>]], -- Replace with the actual code if not <C-6>
			direction = "horizontal", -- Optional: can be 'horizontal', 'vertical', or 'float'
			shade_terminals = true,
		})
	end,
}
