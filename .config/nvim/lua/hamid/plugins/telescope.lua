return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	-- or                              , branch = '0.1.x',
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		-- local builtin = require("telescope.builtin")
		-- vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		-- vim.keymap.set("n", "<C-f>", builtin.git_files, { desc = "Telescope find git files" })
		-- vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		-- vim.keymap.set("v", "<leader>fg", builtin.grep_string, { desc = "Telescope grep string" })
		-- vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Telescope buffers" })
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("flutter")
		require("telescope").load_extension("dap")
	end,
}
