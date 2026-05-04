vim.opt.clipboard = "unnamedplus" -- use system keyboard for yank

vim.opt.nu = true -- set line numbers
vim.opt.relativenumber = true -- use relative line numbers

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hlsearch = true
vim.opt.incsearch = true -- incremental search
vim.opt.inccommand = "split" -- live preview for :s substitutions

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/.undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.filetype.add({
	extension = {
		arb = "json",
	},
})

vim.diagnostic.config({
	severity_sort = true,
	update_in_insert = false,
	underline = true,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		prefix = "●",
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "󰌵",
		},
	},
	float = {
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
})

-- Disable diagnostics inside Neo-tree buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "neo-tree",
	callback = function(args)
		vim.diagnostic.enable(false, { bufnr = args.buf })
	end,
})

require("telescope").load_extension("fzf")
