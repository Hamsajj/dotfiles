return {
	"ibhagwan/fzf-lua",
	config = function()
		require("fzf-lua").setup({
			"telescope",
			winopts = { fullscreen = true },
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --hidden -g '!.git' -g '!.venv' -g '!node_modules' -e",
			},
		})
	end,
}
