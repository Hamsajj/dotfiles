return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"elixir",
			"javascript",
			"html",
			"python",
			"typescript",
			"tsx",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"sql",
			"yaml",
			"json",
			"bash",
			"markdown",
			"markdown_inline",
		}

		require("nvim-treesitter").install(parsers)

		local filetypes = {
			"c",
			"lua",
			"vim",
			"help",
			"elixir",
			"javascript",
			"html",
			"python",
			"typescript",
			"typescriptreact",
			"go",
			"gomod",
			"gosum",
			"gowork",
			"sql",
			"yaml",
			"json",
			"bash",
			"sh",
			"zsh",
			"markdown",
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
		vim.opt.foldcolumn = "0"
		vim.opt.foldtext = ""
	end,
}
