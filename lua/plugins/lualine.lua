local setup, lualine = pcall(require, "lualine")
if not setup then
	return
end

local function clock()
	return os.date("%H:%M:%S")
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
  if not sysname_handle then return "🔋 --%" end

  local sysname = sysname_handle:read("*l")
  sysname_handle:close()

  local cmd
  if sysname == "Darwin" then
    cmd = "pmset -g batt"
  else
    cmd = "acpi -b"
  end

  local handle = io.popen(cmd)
  if not handle then return "🔋 --%" end

  local result = handle:read("*a")
  handle:close()

  if not result or result == "" then return "🔋 --%" end

  result = result:gsub("[\r\n]", ""):match("^%s*(.-)%s*$")

  local percent, status

  if sysname == "Darwin" then
    -- macOS parsing
    percent = result:match("(%d?%d?%d)%%")
    status = result:match("%%;%s*(%a+);") -- grabs 'charging', 'discharging', or 'charged'
  else
    -- Linux (acpi) parsing
    status, percent = result:match("Battery %d+: ([%a%s]+),%s*(%d?%d?%d)%%")
  end

  if not percent or not status then
    return escape_statusline("🔋 --%")
  end

  local icon = "🔋"
  status = status:lower()
  if status:find("charging") then
    icon = "⚡"
  elseif status:find("charged") or status:find("full") then
    icon = "🔌"
  end

  return escape_statusline(string.format("%s %s%%", icon, percent))
end

lualine.setup({
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	options = {
		theme = "catppuccin",
		icons_enabled = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { 'branch' },
		lualine_c = { 'filename' },
		lualine_x = { battery_status, clock, 'encoding', 'fileformat', 'filetype' },
		-- lualine_x = { clock, 'encoding', 'fileformat', 'filetype' },
		lualine_y = { 'progress' },
		lualine_z = { 'location' },
	},
})
