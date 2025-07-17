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

  local cmd
  if sysname == "Darwin" then
    cmd = "pmset -g batt"
  else
    cmd = "acpi -b"
  end

  local handle = io.popen(cmd)
  if not handle then return "" end

  local result = handle:read("*a")
  handle:close()

  if not result or result == "" then return "" end

  result = result:gsub("[\r\n]", ""):match("^%s*(.-)%s*$")

  local percent, status

  if sysname == "Darwin" then
    percent = result:match("(%d?%d?%d)%%")
    -- Match common statuses first
    status = result:match("%%;%s*([%a]+);")
    -- Handle "AC attached; not charging"
    if not status and result:match("%%;%s*AC attached;%s*not charging") then
      status = "ac"
    end
  else
    -- If no battery support (likely a desktop), skip
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

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
		lualine_x = { clock, 'encoding', 'fileformat', 'filetype' },
		-- lualine_x = { battery_status, clock, 'encoding', 'fileformat', 'filetype' },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
