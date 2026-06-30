return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	ft = { "markdown" },
	opts = {
		enabled = false,
	},
	keys = {
		{ "<leader>mp", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown preview", ft = "markdown" },
	},
}
