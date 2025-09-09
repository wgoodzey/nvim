local M = {}

M.setup = function(lspconfig, capabilities, on_attach)
  lspconfig["tailwindcss"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "html",
    "css",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue", -- if you ever use it
  },
  init_options = {
    userLanguages = {
      eelixir = "html",
      eruby = "html",
      heex = "html",
    },
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
        invalidConfigPath = "error",
        recommendedVariantOrder = "warning",
      },
      experimental = {
        classRegex = {
          -- Add any custom regex if you're using special class utilities
        },
      },
    },
  },
})
end

return M
