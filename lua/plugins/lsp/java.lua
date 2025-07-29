local jdtls_status, jdtls = pcall(require, "jdtls")
if not jdtls_status then
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local root_markers = { "pom.xml", "build.gradle", ".git" }
    local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.expand("%:p:h")

    -- Generate a fallback project name from the directory
    local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
    local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name

    local jdtls_bin = vim.fn.exepath("jdtls")
    if vim.fn.empty(jdtls_bin) == 1 then
      vim.notify("JDTLS binary not found", vim.log.levels.ERROR)
      return
    end

    local config = {
      cmd = { jdtls_bin, "-data", workspace_dir },
      root_dir = root_dir,
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      on_attach = function(client, bufnr)
        -- Optional: set your keymaps or commands here
      end,
      settings = {
        java = {
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
        }
      },
    }

    jdtls.start_or_attach(config)
  end,
})
