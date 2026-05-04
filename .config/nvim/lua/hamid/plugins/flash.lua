return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		label = {
			rainbow = { enabled = false },
			style = "inline",
		},
		highlight = {
			backdrop = true,
		},
		modes = {
			search = { enabled = false },
		},
	},
	config = function(_, opts)
		require("flash").setup(opts)
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#1e1e2e", bg = "#f5c2e7" })
		vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#cdd6f4", bg = "#45475a" })
		vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#1e1e2e", bg = "#fab387" })
		vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#6c7086" })
	end,
	keys = {
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	},
}
