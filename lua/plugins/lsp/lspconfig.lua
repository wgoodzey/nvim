-- import lspconfig plugin safely
local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
  return
end

-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
  return
end

-- enable keybinds for available lsp server
local on_attach = function(client, bufr)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Get current working directory
local cwd = vim.fn.getcwd()

require("plugins.lsp.languages.clangd").setup(lspconfig, capabilities, on_attach)
require("plugins.lsp.format").setup()

lspconfig["ltex"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "txt", "markdown", "tex" }
})

lspconfig["tinymist"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "typst" },
})

lspconfig["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

lspconfig["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

-- HTML
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- CSS
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- JavaScript / TypeScript / React
lspconfig["ts_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
})

-- Emmet
lspconfig["emmet_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "html", "css", "scss", "javascriptreact", "typescriptreact",
  },
})

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

-- Rust
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

-- ASM
lspconfig["asm_lsp"].setup({
  filetypes = { "asm", "s", "S" },
})
