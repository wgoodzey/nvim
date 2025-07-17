vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local opt = vim.opt_local
    opt.tabstop = 4
    opt.shiftwidth = 4
    opt.softtabstop = 4
    opt.expandtab = true
    opt.autoindent = true
  end,
})
