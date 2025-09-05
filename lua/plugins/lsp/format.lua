-- lua/plugins/lsp/format.lua
local M = {}

local patterns = { "*.c","*.h","*.cpp","*.hpp","*.cc","*.cxx","*.m","*.mm" }

function M.setup()
  vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "LspFormatOnSave",
    pattern = patterns,
    callback = function()
      vim.lsp.buf.format({
        async = false,
        timeout_ms = 4000,
        filter = function(client) return client.name == "clangd" end,
      })
    end,
  })
end

return M

