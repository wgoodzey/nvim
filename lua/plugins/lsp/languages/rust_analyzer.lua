local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
  lspconfig["rust_analyzer"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "rust" },
    root_dir = require("lspconfig.util").root_pattern("Cargo.toml", "rust-project.json", ".git"),
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
        },
        inlayHints = {
          typeHints = true,
          parameterHints = true,
          chainingHints = true,
        },
        assist = {
          importMergeBehavior = "last",
          importPrefix = "by_self",
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = true,
          },
        },
      },
    },
  })
end

return M