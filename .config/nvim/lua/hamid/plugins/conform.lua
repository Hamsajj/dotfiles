return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				cpp = { "clang-format" },
				python = { "autopep8" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" }, -- for .jsx files
				typescriptreact = { "prettier" }, -- for .tsx files
				vue = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = function(bufnr)
					local filename = vim.api.nvim_buf_get_name(bufnr)
					if filename:match("%.arb$") then
						return { "custom_arb_format" }
					else
						return { "prettier" }
					end
				end,
				yaml = { "yamlfmt" },
				yml = { "yamlfmt" },
				markdown = { "prettier" },
				lua = { "stylua" },
				go = { "golangci-lint" },
				sql = { "custom_pg_format" },
			},
			formatters = {
				custom_pg_format = {
					command = "pg_format",
					args = { "--no-space-function" },
					stdin = true,
				},
				custom_arb_format = {
					command = "prettier",
					args = { "--parser", "json" },
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
