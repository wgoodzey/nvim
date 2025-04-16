vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps

--keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<leader>nh", ":nohl<CR>") -- gets rid of highlighting from search

keymap.set("n", "x", '"_x') -- stops x from adding to clipboard

keymap.set("n", "<leader>+", "<C-a>") -- increments a number
keymap.set("n", "<leader>-", "<C-x>") -- decrements a number

-- slpitting stuff
keymap.set("n", "<leader>sv", "<C-w>v") -- vertical split
keymap.set("n", "<leader>sh", "<C-w>s") -- horizontal split
keymap.set("n", "<leader>se", "<C-w>=") -- make split window eaqual width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- plugin keymaps
-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<Cr>")

-- telescope
keymap.set("n","<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n","<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n","<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n","<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n","<leader>fh", "<cmd>Telescope help_tags<cr>")
keymap.set("n","<leader>t", "<cmd>Telescope<cr>")

-- diffviewer
keymap.set("n","<leader>do", "<cmd>DiffviewOpen <cr>")
keymap.set("n","<leader>dc", "<cmd>DiffviewClose <cr>")
keymap.set("n","<leader>dh", "<cmd>DiffviewFileHistory <cr>")

-- LSP
keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts)													-- show definition, references
keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)						-- got to declaration
keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)									-- see definition and make edits in window
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)				-- go to implementation
keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)							-- see available code actions
keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)									-- smart rename
keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)		-- show  diagnostics for line
keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)	-- show diagnostics for cursor
keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)						-- jump to previous diagnostic in buffer
keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)						-- jump to next diagnostic in buffer
keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)												-- show documentation for what is under cursor
keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)									-- see outline on right hand side
