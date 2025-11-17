-- nvim/lua/plugins/copilot.lua
return {
  "github/copilot.vim",
  cmd = { "Copilot" },
  config = function()
    vim.cmd("Copilot disable")
  end, event = "InsertEnter",
}
