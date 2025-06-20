local opt = vim.opt

-- opt.scrolloff = 3

opt.colorcolumn = "80"

-- line nubmers
opt.number = true
opt.relativenumber = true

-- tabs & indentation
local tab_width = 4
opt.tabstop = tab_width
opt.shiftwidth = tab_width
opt.softtabstop = 4
opt.expandtab = false
opt.autoindent = true

-- line wrapping
opt.linebreak = true
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true

-- appearance
-- opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
--vim.opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
opt.iskeyword:append("_")
