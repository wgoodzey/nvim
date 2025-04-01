local setup, lualine = pcall(require, "lualine")
if not setup then
	return
end

local function clock()
	return os.date("%H:%M:%S")
end

lualine.setup({
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	options = {
		theme = "catppuccin",
		icons_enabled = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename' },
		lualine_x = { clock, 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
})
