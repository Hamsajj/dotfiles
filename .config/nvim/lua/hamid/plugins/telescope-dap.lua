return {
	"nvim-telescope/telescope-dap.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim", -- telescope itself
		"mfussenegger/nvim-dap", -- dap itself
	},
	config = function()
		require("telescope").load_extension("dap")
	end,
}
