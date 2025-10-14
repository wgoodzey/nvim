-- nvim/lua/plugins/core.lua
return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {{
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = function()
    local gs = require("gitsigns")
    return {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "󰍵" },
        topdelete    = { text = "󰍵" },
        changedelete = { text = "▎" },
        untracked    = { text = "▎" },
      },
      signs_staged = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "┃" },
        untracked    = { text = "┆" },
      },

      numhl = false,
      linehl = false,
      word_diff = false,
      attach_to_untracked = true,
      max_file_length = 40000,
      update_debounce = 100,
      preview_config = { border = "rounded" },

      on_attach = function(bufnr)
        local map = function(mode, lhs, rhs, desc, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.desc = desc
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Hunk navigation
        map("n", "]h", function()
          if vim.wo.diff then return "]c" end
          gs.nav_hunk("next")
        end, "Next hunk", { expr = true })
        map("n", "[h", function()
          if vim.wo.diff then return "[c" end
          gs.nav_hunk("prev")
        end, "Prev hunk", { expr = true })

        map("n", "<leader>hd", gs.diffthis, "Diff against index")
        map("n", "<leader>td", gs.toggle_deleted, "Toggle show deleted")
        map("n", "<leader>gw", gs.toggle_word_diff, "Toggle word-diff")
      end,
    }
  end,
},
 "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true
      }
    }
  },
  { "nvim-tree/nvim-web-devicons" },
}
