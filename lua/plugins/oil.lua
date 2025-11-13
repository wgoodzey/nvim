-- nvim/lua/plugins/oil.lua
return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    -- prompt_save_on_select_new_entry = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    float = {
        padding = 2,
        max_width = 120,
        max_height = 30,
        border = "rounded",
      },
    opts = function()
      local actions = require("oil.actions")
      return {
        default_file_explorer = true,
        delete_to_trash = false,
        keymaps = {
          ["q"]        = actions.close,
          ["<CR>"]     = actions.select,
          ["-"]        = actions.parent,
          ["<C-s>"]    = actions.select_split,
          ["<C-v>"]    = actions.select_vsplit,
          ["<C-t>"]    = actions.select_tab,
          ["<Tab>"]    = actions.preview,
          ["r"]        = actions.refresh,
          ["H"]        = actions.toggle_hidden,

          ["y"]        = actions.copy,
          ["m"]        = actions.move,
          ["p"]        = actions.paste,
          ["d"]        = actions.trash,
          ["D"]        = actions.delete,
          ["R"]        = actions.rename,
          ["n"]        = actions.create,
        },
      }
    end,
  },
}
