-- nvim/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("plugins", {
  change_detection = { notify = false },
  ui = { border = "rounded" },
  rocks = { enabled = false }
})

vim.g.loader_ruby_provider = 0
vim.g.loader_pearl_provider = 0
vim.g.loader_node_provider = 0

require("config.options")
require("config.keymaps")
