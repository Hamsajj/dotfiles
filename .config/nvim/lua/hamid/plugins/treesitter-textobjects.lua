return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local select = require("nvim-treesitter-textobjects.select")
		local move = require("nvim-treesitter-textobjects.move")

		local function pick(query)
			return function()
				select.select_textobject(query, "textobjects")
			end
		end

		local s = vim.keymap.set
		s({ "x", "o" }, "af", pick("@function.outer"), { desc = "Around function" })
		s({ "x", "o" }, "if", pick("@function.inner"), { desc = "Inside function" })
		s({ "x", "o" }, "ac", pick("@class.outer"), { desc = "Around class" })
		s({ "x", "o" }, "ic", pick("@class.inner"), { desc = "Inside class" })
		s({ "x", "o" }, "aa", pick("@parameter.outer"), { desc = "Around parameter" })
		s({ "x", "o" }, "ia", pick("@parameter.inner"), { desc = "Inside parameter" })
		s({ "x", "o" }, "ab", pick("@block.outer"), { desc = "Around block" })
		s({ "x", "o" }, "ib", pick("@block.inner"), { desc = "Inside block" })

		s({ "n", "x", "o" }, "]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next function start" })
		s({ "n", "x", "o" }, "[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Prev function start" })
		s({ "n", "x", "o" }, "]F", function()
			move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "Next function end" })
		s({ "n", "x", "o" }, "[F", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "Prev function end" })
		s({ "n", "x", "o" }, "]a", function()
			move.goto_next_start("@parameter.inner", "textobjects")
		end, { desc = "Next parameter" })
		s({ "n", "x", "o" }, "[a", function()
			move.goto_previous_start("@parameter.inner", "textobjects")
		end, { desc = "Prev parameter" })
	end,
}
