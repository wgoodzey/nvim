-- lua/plugins/lsp/languages/clangd.lua
local M = {}

-- Build the clangd command based on the current project
local function build_cmd()
  local cwd = vim.fn.getcwd()

  local cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
    "--all-scopes-completion",
    "--pch-storage=memory",
  }

  -- If there's a CMake-style compilation database under build/
  if vim.fn.filereadable(cwd .. "/build/compile_commands.json") == 1 then
    table.insert(cmd, "--compile-commands-dir=" .. cwd .. "/build")
  end

  -- Detect Pico SDK projects
  local function is_pico_project()
    if vim.fn.glob(cwd .. "/pico_sdk_init.cmake") ~= "" then
      return true
    end
    if vim.fn.getenv("PICO_SDK_PATH") ~= vim.NIL then
      return true
    end
    return false
  end

  if is_pico_project() then
    table.insert(cmd, "--query-driver=/usr/bin/arm-none-eabi-gcc")
  end

  return cmd
end

-- Reuse the same root detection you had
local function root_dir(fname)
  local util = require("lspconfig.util")
  return util.root_pattern(
    "compile_commands.json",
    "compile_flags.txt",
    ".git"
  )(fname)
end

-- Public setup API (keeps lspconfig.lua tiny)
function M.setup(lspconfig, capabilities, on_attach)
  lspconfig.clangd.setup({
    cmd = build_cmd(),
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = root_dir,
  })
end

return M

