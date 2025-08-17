return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				python = { "isort", "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" }, -- for .jsx files
				typescriptreact = { "prettier" }, -- for .tsx files
				vue = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "yamlfmt" },
				yml = { "yamlfmt" },
				markdown = { "prettier" },
				lua = { "stylua" },
				go = { "gofmt" },
				sql = { "custom_pg_format" },
			},
			formatters = {
				custom_pg_format = {
					command = "pg_format",
					args = { "--no-space-function" },
					stdin = true,
				},
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
