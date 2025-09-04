vim.o.cmdheight = 0

local setup, lualine = pcall(require, "lualine")
if not setup then
  return
end

local function clock()
  return os.date("%I:%M:%S %p")
end

local function escape_statusline(str)
  return str
      :gsub("%%", "%%%%")
      :gsub(",", "\\,")
      :gsub("<", "\\<")
      :gsub(">", "\\>")
end

local function battery_status()
  local sysname_handle = io.popen("uname")
  if not sysname_handle then return "" end
  local sysname = sysname_handle:read("*l")
  sysname_handle:close()

  local cmd = (sysname == "Darwin") and "pmset -g batt" or "acpi -b"
  local handle = io.popen(cmd)
  if not handle then return "" end

  local result = handle:read("*a") or ""
  handle:close()
  if result == "" then return "" end
  result = result:gsub("[\r\n]", ""):match("^%s*(.-)%s*$")

  local percent, status
  if sysname == "Darwin" then
    percent = result:match("(%d?%d?%d)%%")
    status = result:match("%%;%s*([%a]+);")
    if not status and result:match("%%;%s*AC attached;%s*not charging") then
      status = "ac"
    end
  else
    if result:lower():find("no support") or result:lower():find("unavailable") then
      return ""
    end
    status, percent = result:match("Battery %d+: ([%a%s]+),%s*(%d?%d?%d)%%")
  end

  if not percent or not status then
    return ""
  end

  local icon = "🔋"
  status = status:lower()
  if status:find("charging") then
    icon = "⚡"
  elseif status:find("charged") or status:find("full") or status == "ac" then
    icon = "🔌"
  end

  return escape_statusline(string.format("%s %s%%", icon, percent))
end

-- NEW: define the component and its color
local function battery_component()
  return battery_status()
end

local function battery_color()
  local s = battery_status()
  local pct = tonumber((s or ""):match("(%d+)%%"))
  if not pct then return {} end
  if pct < 20 then
    return { fg = "#ff5555" } -- red-ish
  elseif pct < 50 then
    return { fg = "#f1fa8c" } -- yellow-ish
  else
    return { fg = "#50fa7b" } -- green-ish
  end
end

local function has_battery()
  local sys = (jit and jit.os) or vim.loop.os_uname().sysname
  if tostring(sys):find("Darwin") or tostring(sys):find("Windows") then
    return true
  end
  return vim.fn.glob("/sys/class/power_supply/BAT*") ~= ""
end

local lualine_x = { clock, 'encoding', 'fileformat', 'filetype' }
if has_battery() then
  table.insert(lualine_x, 1, { battery_component, color = battery_color })
end

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { statusline = {}, winbar = {} },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = { statusline = 100, tabline = 100, winbar = 100 },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = lualine_x,
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

