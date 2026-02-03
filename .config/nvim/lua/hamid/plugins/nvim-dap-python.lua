return {
	"mfussenegger/nvim-dap-python",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	config = function()
		-- Path to the python interpreter that has debugpy installed
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")
		dap_python.setup("python3")

		dapui.setup()

		-- Auto-open/close UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Django Runserver",
				program = vim.fn.getcwd() .. "/manage.py",
				args = { "runserver" },
				django = true,
				justMyCode = false,
				console = "integratedTerminal",
			},
		}
	end,
}
