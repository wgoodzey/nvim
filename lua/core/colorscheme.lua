-- Setup for Catppuccin
require("catppuccin").setup({
  flavour = "mocha", -- You can choose between "latte", "frappe", "macchiato", and my favorite "mocha"
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    lsp_trouble = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    nvimtree = true,
    which_key = true,
  },
  custom_highlights = function(colors)
    -- require here so it's always in scope when this function runs
    local u = require("catppuccin.utils.colors")
    return {
      ColorColumn = { bg = u.darken(colors.base, 0.85, colors.crust) },
      CursorLine  = { bg = u.lighten(colors.surface0, 0.95, colors.text) },
    }
  end,
})

-- Apply the theme
vim.cmd.colorscheme("catppuccin")
