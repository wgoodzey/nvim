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
  local handle = io.popen("acpi -b")
  if not handle then return "🔋 --%" end

  local result = handle:read("*a")
  handle:close()

  if not result or result == "" then return "🔋 --%" end

  result = result:gsub("[\r\n]", ""):match("^%s*(.-)%s*$")

  local status, percent = result:match("Battery %d+: ([%a%s]+),%s*(%d?%d?%d)%%")
  if not percent then
    return escape_statusline("🔋 --%")
  end

  local icon = "🔋"
  status = status:lower()
  if status:find("charging") then
    icon = "⚡"
  elseif status:find("full") then
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
