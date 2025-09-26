-- lua/plugins/lsp/languages/ocamllsp.lua
local M = {}

local function root_dir(fname)
  local util = require("lspconfig.util")
  return util.root_pattern("_opam", "dune-project", "esy.json", "package.json", ".git")(fname)
end

function M.setup(lspconfig, capabilities, on_attach)
  lspconfig.ocamllsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = root_dir,
  })
end

return M
