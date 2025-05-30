return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"elixir",
				"javascript",
				"html",
				"python",
				"typescript",
				"go",
				"gomod",
				"sql",
				"yaml",
				"json",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
		-- ✅ Enable Tree-sitter based folding
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 99 -- Open all folds by default
		vim.opt.foldlevelstart = 99 -- For newly opened buffers
	end,
}
