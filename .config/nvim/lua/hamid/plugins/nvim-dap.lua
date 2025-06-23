return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		local dap_env = require("utils.dotenv")
		local env = dap_env.load_env_file(vim.fn.getcwd() .. "/.env")
		print(vim.inspect(env))

		local dap = require("dap")
		for _, configs in pairs(dap.configurations) do
			for _, config in ipairs(configs) do
				config.env = vim.tbl_extend("force", config.env or {}, env)
			end
		end
	end,
}
