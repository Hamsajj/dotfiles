return {
	"ibhagwan/fzf-lua",
	config = function()
		require("fzf-lua").setup({ { "telescope", "borderless" }, winopts = { fullscreen = true } })
	end,
}
