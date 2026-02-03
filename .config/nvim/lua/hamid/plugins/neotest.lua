return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",

		-- Python adapter:
		"nvim-neotest/neotest-python",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-python")({
					dap = { justMyCode = true }, -- optional, for debugging
					is_test_file = function(file_path)
						local file_name = file_path:match("^.+/(.+)$") or file_path
						file_name = file_name:lower()
						return file_name:match("test") ~= nil and file_name:sub(-3) == ".py"
					end,
				}),
			},
		})
	end,
}
