-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
			return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins when
-- file is saved

vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
	augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	use { "wbthomason/packer.nvim" }					-- Packer can manage self
	use { "catppuccin/nvim", as = "catppuccin" }
	use { "nvim-lua/plenary.nvim" }						-- needed for a lot of plugins
	use { "christoomey/vim-tmux-navigator" }	-- move between splits with control + vim-motions
	use { "szw/vim-maximizer" }
	use { "tpope/vim-surround" }							-- for surrounding text with stuff like ""
	use { "numToStr/Comment.nvim" }						-- comment stuff out with gc
	use { "nvim-tree/nvim-tree.lua" }					-- file explorer
	use { "nvim-tree/nvim-web-devicons" }			-- icons
	use { "nvim-lualine/lualine.nvim" }				-- upgraded status bar

	-- fuzzy finding
	use { "nvim-telescope/telescope.nvim", branch = "0.1.x" }	-- for grepping through projet
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

	-- autocompletion
	use { "hrsh7th/nvim-cmp" }								-- completion
	use { "hrsh7th/cmp-buffer" }							-- source for text in buffer
	use { "hrsh7th/cmp-path" }								-- source for file system paths

	-- snippets
	use { "L3MON4D3/LuaSnip" }								-- snippet engine
	use { "saadparwaiz1/cmp_luasnip" }				-- for autocompletion
	use { "rafamadriz/friendly-snippets" }		-- for snippets

	-- LSP, linters, and formatters
	use { "williamboman/mason.nvim",
				tag = "v1.8.3" }							-- manages LSP servers,
	use { "williamboman/mason-lspconfig.nvim",
				tag = "v1.24.0" }		-- bridges mason with lspconfig

	use { "akinsho/flutter-tools.nvim" }			-- for Flutter

	use { "neovim/nvim-lspconfig" }						-- configure language servers
	use { "hrsh7th/cmp-nvim-lsp" }						-- for autocompletion
	use { "nvimdev/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" }
		},
	}																					-- for better LSP UI

	use { "onsails/lspkind.nvim" }						-- vs-code like icons for autocompletion

	use { "nvim-treesitter/nvim-treesitter" }	-- for syntax highlighting

	use { "sindrets/diffview.nvim" }					-- powerful diff viewer, works in tandem with git

	use { "akinsho/toggleterm.nvim",
		config = function()
			require("plugins.toggleterm")
		end,
	}																					-- for a powerful terminal inside neovim

	use { "kaarmu/typst.vim" }								-- typst syntax highlighting

	use { "cameron-wags/rainbow_csv.nvim",
		config = function()
			require("rainbow_csv").setup()
		end,
		module = {
			"rainbow_csv",
			"rainbow_csv.fns",
		},
		ft = {
			"csv",
			"tsv",
			"csv_semicolon",
			"csv_whitespace",
			"csv_pipe",
			"rfc_csv",
			"rfc_semicolon",
		}
	}																					-- for colored csv support

	-- use { "" }	-- 

	if packer_bootstrap then
		require("packer").sync()
	end

end)
