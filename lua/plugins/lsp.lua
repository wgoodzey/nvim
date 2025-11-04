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
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = (ok_cmp and cmp_nvim_lsp.default_capabilities and cmp_nvim_lsp.default_capabilities()) or
          vim.lsp.protocol.make_client_capabilities()

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          }
        }
      })

      local on_attach = function(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- LSP nav/actions
        map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "<leader>fd", function() vim.diagnostic.open_float(nil, { border = "rounded" }) end, "Line Diagnostics")
      end

      local has_lspconfig, lspconfig = pcall(require, "lspconfig")

      local function setup(name, opts)
        opts = opts or {}
        opts.capabilities = opts.capabilities or capabilities
        opts.on_attach = opts.on_attach or on_attach

        -- New API
        local has_new_api = vim.lsp and type(vim.lsp.config) == "function"
        if has_new_api then
          local ok = pcall(vim.lsp.config, name, opts)
          if ok and type(vim.lsp.enable) == "function" then pcall(vim.lsp.enable, name) end
          if ok then return end
        end

        --  Legacy
        if has_lspconfig and lspconfig and lspconfig[name] and type(lspconfig[name].setup) == "function" then
          lspconfig[name].setup(opts)
          return
        end

        -- neither worked
        vim.notify("Unable to register LSP server: " .. name, vim.log.levels.WARN)
      end

      local ok_util, util = pcall(require, "lspconfig.util")
      if not ok_util then
        util = {
          path = vim.deepcopy(vim.loop),
          dirname = function(p)
            return p and p:match("(.*)/") or nil
          end,
          root_pattern = function(...)
            local patterns = { ... }
            return function(fname)
              local dir = fname and fname:match("(.*)/") or vim.loop.cwd()
              for _, p in ipairs(patterns) do
                local cur = dir
                while cur and cur ~= '' do
                  if vim.fn.globpath(cur, p) ~= '' then return cur end
                  cur = cur:match("(.*)/")
                end
              end
              return nil
            end
          end,
        }
      end

      local function safe_dirname(fname)
        if not fname or fname == "" then return vim.loop.cwd() end
        local dir
        if util.path and util.path.dirname then
          dir = util.path.dirname(fname)
        elseif util.dirname then
          dir = util.dirname(fname)
        else
          dir = fname:match("(.*)/")
        end
        return (dir and dir ~= "") and dir or vim.loop.cwd()
      end

      local function root_dir(fname)
        local root = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
        return root or safe_dirname(fname)
      end

      local function clangd_cmd()
        if vim.fn.executable("clangd") == 1 then return { "clangd" } end
        local hb = "/opt/homebrew/opt/llvm/bin/clangd"
        if vim.fn.executable(hb) == 1 then return { hb } end
        return { "clangd" }
      end

      setup("clangd", {
        cmd = vim.list_extend(clangd_cmd(), {
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--all-scopes-completion",
          "--pch-storage=memory",
        }),
        root_dir = root_dir,
        single_file_support = true,
        filetypes = { "c", "cpp", "objc", "objcpp" },
      })

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.c", "*.cpp", "*.cc", "*.h", "*.hpp", "*.m", "*.mm", "*.cu" },
        callback = function(args)
        end,
      })

      setup("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          },
        },
      })

      setup("pyright")
      setup("rust_analyzer")
      setup("marksman")

      pcall(function()
        require("mason").setup()
        require("mason-lspconfig").setup()
      end)
    end,
  },
}
