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

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(ev)
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
          map("n", "gr", vim.lsp.buf.references, "References")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("n", "<leader>fd", function()
            vim.diagnostic.open_float(nil, { border = "rounded" })
          end, "Line Diagnostics")

          map("n", "<leader>cf", function()
            vim.lsp.buf.format({ async = false })
          end, "Format Code")
        end,
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
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
}
