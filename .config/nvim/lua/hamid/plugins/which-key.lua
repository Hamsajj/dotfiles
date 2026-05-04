return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		delay = 200,
		plugins = {
			marks = false,
			registers = false,
			spelling = { enabled = true, suggestions = 20 },
			presets = {
				operators = false,
				motions = false,
				text_objects = false,
				windows = true,
				nav = false,
				z = true,
				g = false,
			},
		},
		spec = {
			{ "<leader>f", group = "Find" },
			{ "<leader>l", group = "LSP" },
			{ "<leader>h", group = "Harpoon" },
			{ "<leader>t", group = "Test" },
		},
		icons = {
			breadcrumb = "»",
			separator = "➜",
			group = "+",
			rules = false,
		},
		win = {
			border = "single",
			padding = { 1, 2 },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
