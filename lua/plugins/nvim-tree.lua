local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end


-- recommended settings for nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
