require("hamid")
-- filter which-key warnings
local orig_notify = vim.notify
vim.notify = function(msg, level, opts)
	if msg:match("which%-key") and level == vim.log.levels.WARN then
		return
	end
	orig_notify(msg, level, opts)
end
local clip = "/mnt/c/Windows/System32/clip.exe"
if vim.fn.executable(clip) == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = vim.api.nvim_create_augroup("WSLYank", { clear = true }),
		callback = function()
			if vim.v.event.operator == "y" then
				local text = vim.fn.getreg('"')
				vim.fn.system(clip, text)
			end
		end,
	})
end
