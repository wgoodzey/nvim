local opt = vim.opt

vim.api.nvim_autocmd("FileType", {
	pattern = "java",
	callback = function()
		opt.tabstop = 4
		opt.shiftwidth = 4
		opt.softtabstop = 4
		opt.expandtab = true
		opt.autoindent = true
	end,
})
