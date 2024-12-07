local setup, lualine = pcall(require, "lualine")
    if not setup then
        return
    end

lualine.setup({
  options = {
    --theme = '', -- Example theme; choose any theme you like
    section_separators = { left = '|', right = '|' },
    component_separators = { left = '◂', right = '▸' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})
