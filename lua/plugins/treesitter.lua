-- nvim/lua/plugins/treesitter.lua
return {
  {
    "romus204/tree-sitter-manager.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "c", "cpp", "java", "python", "bash", "lua", "vim", "vimdoc", "json", "yaml", "markdown" },
      highlight = true,
    },
    config = function(_, opts)
      require("tree-sitter-manager").setup(opts)
    end
  }
}
