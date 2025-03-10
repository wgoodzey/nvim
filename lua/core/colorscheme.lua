-- vim.cmd('colorscheme industry')

-- Set up Catppuccin
require("catppuccin").setup({
    flavour = "mocha", -- You can choose between "latte", "frappe", "macchiato", and "mocha"
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
})

-- Apply the theme
vim.cmd.colorscheme("catppuccin")
