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
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		-- If telescope was opened from neo-tree, redirect the open target
		-- to a non-neotree window so splits land in the main editor area.
		local function redirect_from_neotree(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			if not picker or not picker.original_win_id then
				return
			end
			local origin_buf = vim.api.nvim_win_get_buf(picker.original_win_id)
			if vim.bo[origin_buf].filetype ~= "neo-tree" then
				return
			end
			for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.bo[buf].filetype
				if ft ~= "neo-tree" and ft ~= "TelescopePrompt" then
					picker.original_win_id = win
					return
				end
			end
		end

		local function smart(action)
			return function(prompt_bufnr)
				redirect_from_neotree(prompt_bufnr)
				action(prompt_bufnr)
			end
		end

		telescope.setup({
			defaults = {
				preview = {
					treesitter = false,
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
				mappings = {
					i = {
						["<CR>"] = smart(actions.select_default),
						["<C-s>"] = smart(actions.select_vertical),
						["<C-x>"] = smart(actions.select_horizontal),
						["<C-t>"] = smart(actions.select_tab),
					},
					n = {
						["<CR>"] = smart(actions.select_default),
						["<C-s>"] = smart(actions.select_vertical),
						["<C-x>"] = smart(actions.select_horizontal),
						["<C-t>"] = smart(actions.select_tab),
					},
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden",
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
