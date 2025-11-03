-- nvim/config/keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- General
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>h", ":nohlsearch<CR>", opts)

map("n", ":", ";", opts)
map("n", ";", ":", opts)

-- Window splitting
map("n", "<leader>sv", function() vim.cmd("vsplit") end, opts)
map("n", "<leader>sh", function() vim.cmd("split") end, opts)

-- Better window movement
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- LSP (when attached)
map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
map("n", "<leader>cr", vim.lsp.buf.rename, opts)
map("n", "<leader>cd", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<leader>g", vim.diagnostic.open_float, {desc = "Line Diagnostics"})

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)

-- Oil
map("n", "<leader>e", function() require("oil").open() end, opts)
