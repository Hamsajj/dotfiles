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
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()

		-- Defaults applied to every server
		vim.lsp.config("*", {
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				if vim.bo[bufnr].filetype == "neo-tree" then
					client.stop()
				end
			end,
		})

		-- Per-server overrides
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					diagnostics = { globals = { "vim", "love" } },
					workspace = {
						library = { vim.env.VIMRUNTIME },
						checkThirdParty = false,
					},
					hint = { enable = true },
				},
			},
		})

		vim.lsp.config("ts_ls", {
			settings = {
				typescript = {
					inlayHints = {
						includeInlayParameterNameHints = "literals",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
				javascript = {
					inlayHints = {
						includeInlayParameterNameHints = "literals",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
				},
			},
		})

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						compositeLiteralTypes = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
			},
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					inlayHints = {
						bindingModeHints = { enable = false },
						chainingHints = { enable = true },
						closingBraceHints = { enable = true, minLines = 25 },
						closureReturnTypeHints = { enable = "never" },
						lifetimeElisionHints = { enable = "never", useParameterNames = false },
						maxLength = 25,
						parameterHints = { enable = true },
						reborrowHints = { enable = "never" },
						renderColons = true,
						typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
					},
				},
			},
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
				"eslint",
				"ts_ls",
				"tailwindcss",
				"protols",
				"pyright",
				"ruff",
			},
			automatic_enable = true,
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
