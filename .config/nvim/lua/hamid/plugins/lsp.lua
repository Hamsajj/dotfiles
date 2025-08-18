-- https://lsp-zero.netlify.app/v3.x/blog/theprimeagens-config-from-2022.html
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/lazy/lsp.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"petertriho/cmp-git",
		"rafamadriz/friendly-snippets",
		"Snikimonkd/cmp-go-pkgs",
		"David-Kunz/cmp-npm",
		"davidsierradz/cmp-conventionalcommits",
		"coder3101/protols",
		-- "tailwindlabs/tailwindcss-intellisense",
		-- "typescript-language-server/typescript-language-server",
	},
	config = function()
		vim.lsp.config("lua_ls", {
			on_init = function(client)
				if client.workspace_folders then
					local path = client.workspace_folders[1].name
					if
						path ~= vim.fn.stdpath("config")
						and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
					then
						return
					end
				end

				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Tell the language server which version of Lua you're using (most
						-- likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
						-- Tell the language server how to find Lua modules same way as Neovim
						-- (see `:h lua-module-load`)
						path = {
							"lua/?.lua",
							"lua/?/init.lua",
						},
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- Depending on the usage, you might want to add additional paths
							-- here.
							-- '${3rd}/luv/library'
							-- '${3rd}/busted/library'
						},
						-- Or pull in all of 'runtimepath'.
						-- NOTE: this is a lot slower and will cause issues when working on
						-- your own configuration.
						-- See https://github.com/neovim/nvim-lspconfig/issues/3189
						-- library = {
						--   vim.api.nvim_get_runtime_file('', true),
						-- }
					},
				})
			end,
			settings = {
				Lua = {},
			},
		})
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ruff",
				"rust_analyzer",
				"gopls",
				"eslint",
				"ts_ls",
				"tailwindcss",
				"protols",
			},
			handlers = {
				function(server_name)
					local opts = {
						capabilities = capabilities,
					}
					if server_name == "lua_ls" then
						opts.settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = {
									globals = { "vim", "love" },
								},
								workspace = {
									library = {
										vim.env.VIMRUNTIME,
									},
									checkThirdParty = false,
								},
							},
						}
					end
					require("lspconfig")[server_name].setup(opts)
				end,
			},
		})

		require("lspconfig").dartls.setup({
			capabilities = capabilities,
			cmd = { "dart", "language-server", "--protocol=lsp" },
			filetypes = { "dart" },
			init_options = {
				closingLabels = true,
				outline = true,
				flutterOutline = true,
			},
		})
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		-- this is the function that loads the extra snippets to luasnip
		-- from rafamadriz/friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 3 },
				{ name = "friendly-snippets", keyword_length = 2 },
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						local selected = cmp.get_selected_entry()
						if selected then
							cmp.confirm({ select = false })
						else
							cmp.select_next_item()
						end
					elseif
						vim.fn.col(".") ~= 1
						and vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s") == nil
					then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-.>"] = cmp.mapping(function(fallback)
					cmp.complete()
				end, { "i", "c" }),

				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
		})
	end,
}
