local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end


-- recommended settings for nvim-tree documentation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup({
  view = {
    side = "right",
    width = 35,
  },
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
