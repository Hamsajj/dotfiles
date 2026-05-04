return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		require("lualine").setup({
			options = {
				theme = "auto",
				globalstatus = true,
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
				},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{ "diagnostics", sources = { "nvim_lsp" } },
					{ "filename", path = 1, symbols = { modified = "●", readonly = "", unnamed = "[No Name]" } },
				},
				lualine_x = {
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if #clients == 0 then
								return ""
							end
							local names = {}
							for _, c in ipairs(clients) do
								table.insert(names, c.name)
							end
							return " " .. table.concat(names, ",")
						end,
					},
					"encoding",
					"filetype",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			extensions = { "neo-tree", "lazy", "trouble", "quickfix", "fugitive" },
		})

		vim.opt.showmode = false
	end,
}
