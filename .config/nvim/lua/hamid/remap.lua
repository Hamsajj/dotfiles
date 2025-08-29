local which_key = require("which-key")
local builtin = require("telescope.builtin")
local telescope = require("telescope")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(event)
		local lint = require("lint")
		-- LSP mappings using new which-key spec
		which_key.add({
			{ "gd", vim.lsp.buf.definition, desc = "Go to definition", buffer = event.buf },
			{ "gl", vim.diagnostic.open_float, desc = "Open diagnostic float", buffer = event.buf },
			{ "K", vim.lsp.buf.hover, desc = "Show hover information", buffer = event.buf },
			{ "<leader>l", group = "LSP", buffer = event.buf, mode = { "n", "v" } },
			{ "<leader>la", vim.lsp.buf.code_action, desc = "Code action", buffer = event.buf, mode = { "n", "v" } },
			{ "<leader>lr", vim.lsp.buf.references, desc = "References", buffer = event.buf },
			{ "<leader>li", vim.lsp.buf.implementation, desc = "Implementation", buffer = event.buf },
			{ "<leader>ln", vim.lsp.buf.rename, desc = "Rename", buffer = event.buf },
			{ "<leader>lw", vim.lsp.buf.workspace_symbol, desc = "Workspace symbol", buffer = event.buf },
			{ "<leader>ld", vim.diagnostic.open_float, desc = "Open diagnostic float", buffer = event.buf },
			{ "<leader>lt", lint.try_lint, desc = "Lint current file", buffer = event.buf },
			{
				"[d",
				function()
					vim.diagnostic.jump({ count = 1, float = true })
				end,
				desc = "Go to next diagnostic",
				buffer = event.buf,
			},
			{
				"]d",
				function()
					vim.diagnostic.jump({ count = -1, float = true })
				end,
				desc = "Go to previous diagnostic",
				buffer = event.buf,
			},
		})
		-- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		--     buffer = event.buf,
		--     callback = function()
		--         vim.lsp.buf.format({ async = false, id = event.data.client_id })
		--     end,
		-- })
	end,
})


-- Non-LSP mappings using new which-key spec
which_key.add({
	{ "<C-d>", "<C-d>zz", desc = "Half page down and center" },
	{ "<C-u>", "<C-u>zz", desc = "Half page up and center" },
	{ "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
	{ "<leader>e", "<Cmd>Neotree reveal<CR>", desc = "Open file explorer" },
	{ "<leader>p", '"_dP', desc = "Paste without overwrite" },
	{
		"<leader>s",
		":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
		desc = "Search and replace word under cursor",
	},
	{
		"<leader>s",
		'"hy:%s/<C-r>h/<C-r>h/gI<Left><Left><Left>',
		desc = "Search and replace selected text",
		mode = "v",
	},
	{
		"J",
		"mzJ`z",
		desc = "Join lines and keep cursor position",
	},
	{ "N", "Nzzzv", desc = "Previous search result and center" },
	{ "Q", "<nop>", desc = "Disable Ex mode" },
	{ "n", "nzzzv", desc = "Next search result and center" },
})

local hm = require("harpoon.mark")
local hu = require("harpoon.ui")
which_key.add({
	{ "<leader>h", group = "Harpoon" },
	{ "<leader>ha", hm.add_file, desc = "Mark file" },
	{ "<leader>a", hm.add_file, desc = "Mark file" },
	{ "<leader>hh", hu.toggle_quick_menu, desc = "Toggle Harpoon UI" },
})

which_key.add({
	{ "<leader>f", group = "Find" },

	-- telescope builtins
	{ "<leader>ff", builtin.find_files, desc = "Find files" },
	{ "<leader>fb", builtin.buffers, desc = "Open buffers" },
	{ "<leader>fg", builtin.git_files, desc = "Find git files" },
	{ "<leader>fl", builtin.live_grep, desc = "Live grep" },
	{ "<leader>fg", builtin.grep_string, { desc = "Grep selected string" }, mode = { "v" } },
	{ ";", builtin.buffers, desc = "Find Buffers" },

	-- telescope-extensions
	{ "<leader>fd", telescope.extensions.dap.commands, desc = "DAP commands" },
	{ "<leader>fv", telescope.extensions.dap.variables, desc = "DAP variables" },
	{ "<leader>fo", telescope.extensions.flutter.commands, desc = "Flutter commands" },
	{ "<leader>fe", telescope.extensions.harpoon.marks, desc = "Harpoon marks" },
})

-- Visual mode mappings using new which-key spec
which_key.add({
	{ "J", ":m '>+1<CR>gv=gv", desc = "Move selection down", mode = "v" },
	{ "K", ":m '<-2<CR>gv=gv", desc = "Move selection up", mode = "v" },
	{ "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment", mode = "v" },
})

-- Register cmp mappings with which-key for documentation purposes
-- Note: These are just for documentation, the actual mappings are handled by cmp
which_key.add({
	{ "<Tab>", fesc = "Next completion item / Trigger completion", mode = "i" },
	{ "<S-Tab>", desc = "Previous completion item", mode = "i" },
	{ "<C-.>", desc = "Trigger completion", mode = { "i", "c" } },
	{ "<C-CR>", desc = "Smart LSP action/completion", mode = { "i", "n", "v" } },
	{ "<CR>", desc = "Confirm completion", mode = "i" },
})

which_key.add({
	{ "<leader>n", ":bnext<CR>", desc = "Next buffer", mode = "n" },
	{ "<leader>p", ":bprev<CR>", desc = "Prev buffer", mode = "n" },
})

which_key.add({
	{
		"<leader>w",
		function()
			local picked_window_id = require("window-picker").pick_window()
			if picked_window_id then
				vim.api.nvim_set_current_win(picked_window_id)
			end
		end,
		desc = "Window picker",
		mode = "n",
	},
})

-- Insert mode mapping (keep as regular keymap since which-key doesn't handle these)
vim.keymap.set("i", "<Right>", "<Right>", { noremap = true }) -- Make the right arrow behave normally in insert mode
