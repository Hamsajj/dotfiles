return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	event = { "BufReadPost", "BufNewFile" },
	opts = {},
	keys = {
		{
			"]t",
			function()
				require("todo-comments").jump_next()
			end,
			desc = "Next todo comment",
		},
		{
			"[t",
			function()
				require("todo-comments").jump_prev()
			end,
			desc = "Prev todo comment",
		},
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
		{ "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Find todos/fixes" },
	},
}
