-- nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      pcall(require, "lspconfig")

      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp-nvim-lsp")
      local capabilities = (ok_cmp and cmp_nvim_lsp.default_capabilities and cmp_nvim_lsp.default_capabilities())
        or vim.lsp.protocol.make_client_capabilities()

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.HINT]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
          },
        },
      })

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>fd", function()
          vim.diagnostic.open_float(nil, { border = "rounded" })
        end, "Line Diagnostics")
      end

      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      local servers = { "clangd", "lua_ls", "pyright", "rust_analyzer", "marksman" }

      for _, name in ipairs(servers) do
        vim.lsp.enable(name)
      end

      pcall(function()
        require("mason").setup()
        require("mason-lspconfig").setup()
      end)
    end,
  },
}
