return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	mappings = {
		i = {
			["<C-s>"] = "select_vertical",
		},
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-s>"] = require("telescope.actions").select_vertical,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("flutter")
		telescope.load_extension("dap")
		telescope.load_extension("harpoon")
	end,
}
