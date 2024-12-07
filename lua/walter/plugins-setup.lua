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

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
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
    -- packer can manage itself
    use("wbthomason/packer.nvim")

    use("nvim-lua/plenary.nvim")

    use("christoomey/vim-tmux-navigator") -- moves between splits with control + hjkl

    use("szw/vim-maximizer") -- maximizes current window

    use("tpope/vim-surround") -- suround stuff with stuff like ""

    use("numToStr/Comment.nvim") -- comments stuff out with gc

    use("nvim-tree/nvim-tree.lua") -- file explorer

    use ("kyazdani42/nvim-web-devicons") -- icons

    use ("nvim-lualine/lualine.nvim") -- statusline

    -- fuzzy find
    use({"nvim-telescope/telescope-fzf-native.nvim", run = "make"})
    use({"nvim-telescope/telescope.nvim", branch = "0.1.x"})

    -- autocompletion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    
    -- snippets
    use("L3Mon4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")

    

    if packer_bootstrap then
        require("packer").sync()
    end
end)

