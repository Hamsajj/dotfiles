vim.opt.clipboard = 'unnamedplus' -- use system keyboard for yank

vim.opt.nu = true                 -- set line numbers -- set line numbers

vim.opt.relativenumber = true     -- use relative line numbers


-- set tab size to 2 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true -- incremental search

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/.undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true


vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
