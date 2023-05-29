local M = {}
---@class custom_palette
---@field public orange string "#FF5F42"
---@field public neonred string "#FF4278"
---@field public dark_cyan string "#31748f"
---@field public light_cyan string "#6BE8FF"
---@field public white_text string "#e0def4"
---@field public lavender string "#C89CFF"
---@field public pinkish string "#FFA4D7"
---@field public light_yellow string "#FAE3B0"
---@field public purple string "#AF5BE3"
---@field public middle_cat string "#1E2035"
---@field public middle_rose string "#1E2035"
---@field public dark_cat string "#1E2035"
---@field public dark_rose string "#1E2035"
---@field public dark_neon string "#1E2035"
---@field public dark_grey string "#1E2035"
---@field public neutral_purple string "#241F31"
---@field public grayish string "#A6ADC8"
---@field public leaves string "#63B1B7"
---@field public tree string "#63B1B7"

---@type custom_palette
local custom_palette = {
	neonred = '#FF4278',
	orange = '#FF5F42',
	purple = '#AF5BE3',
	light_cyan = '#6BE8FF',
	white_text = '#e0def4',
	lavender = '#C89CFF',
	dark_cyan = '#31748f',
	pinkish = '#FFA4D7',
	light_yellow = '#FAE3B0',
	dark_cat = '#1e1e2e',
	dark_rose = '#191724',
	middle_cat = '#24273a',
	middle_rose = '#232136',
	dark_grey = '#1C1E27',
	dark_neon = '#1E2035',
	grayish = '#A6ADC8',
	leaves = '#63B1B7',
	tree = '#191724',
	neutral_purple = '#241f31',
}

---@class palette
---@field public rosewater string "#f5e0dc"
---@field public flamingo string "#f2cdcd"
---@field public mauve string "#f5c2e7"
---@field public pink string "#cba6f7"
---@field public red string "#f38ba8"
---@field public maroon string "#eba0ac"
---@field public peach string "#fab387"
---@field public yellow string "#f9e2af"
---@field public green string "#a6e3a1"
---@field public sapphire string "#94e2d5"
---@field public blue string "#89dceb"
---@field public sky string "#74c7ec"
---@field public teal string "#89b4fa"
---@field public lavender string "#b4befe"
---@field public text string
---@field public subtext1 string
---@field public subtext0 string
---@field public overlay2 string
---@field public overlay1 string
---@field public overlay0 string
---@field public surface2 string
---@field public surface1 string
---@field public surface0 string
---@field public base string "#1e1e2e"
---@field public mantle string "#181825"
---@field public crust string "#11111b"
---@field public none "NONE"

---@type palette
local palette = nil

local catppuccin_mocha = {
	rosewater = '#f5e0dc',
	flamingo = '#f2cdcd',
	mauve = '#f5c2e7',
	pink = '#cba6f7',
	red = '#f38ba8',
	maroon = '#eba0ac',
	peach = '#fab387',
	yellow = '#f9e2af',
	green = '#a6e3a1',
	teal = '#94e2d5',
	sky = '#89dceb',
	sapphire = '#74c7ec',
	blue = '#89b4fa',
	lavender = '#b4befe',

	text = '#cdd6f4',
	subtext1 = '#bac2de',
	subtext0 = '#a6adc8',
	overlay2 = '#9399b2',
	overlay1 = '#7f849c',
	overlay0 = '#6c7086',
	surface2 = '#585b70',
	surface1 = '#45475a',
	surface0 = '#313244',

	base = '#1e1e2e',
	mantle = '#181825',
	crust = '#11111b',
}

---Initialize the palette
---@return palette
local function init_palette()
	if not palette then
		palette = catppuccin_mocha
	end

	return palette
end

---Generate universal highlight groups
---@param overwrite palette? @The color to be overwritten | highest priority
---@return palette
function M.get_palette(overwrite)
	if not overwrite then
		return init_palette()
	else
		return vim.tbl_extend('force', init_palette(), overwrite)
	end
end

-- Get set of custom colors
---@return custom_palette
function M.get_custom_palette() return custom_palette end

---@param color string @The color in hexadecimal.
local function hexToRgb(color)
	color = string.lower(color)
	return {
		tonumber(color:sub(2, 3), 16),
		tonumber(color:sub(4, 5), 16),
		tonumber(color:sub(6, 7), 16),
	}
end

---Parse the `style` string into nvim_set_hl options
---@param style string @The style config
---@return table
local function parse_style(style)
	if not style or style == 'NONE' then return {} end

	local result = {}
	for field in string.gmatch(style, '([^,]+)') do
		result[field] = true
	end

	return result
end

---Wrapper function for nvim_get_hl_by_name
---@param hl_group string @Highlight group name
---@return table
local function get_highlight(hl_group)
	local hl = vim.api.nvim_get_hl_by_name(hl_group, true)
	if hl.link then return get_highlight(hl.link) end

	local result = parse_style(hl.style)
	result.fg = hl.foreground and string.format('#%06x', hl.foreground)
	result.bg = hl.background and string.format('#%06x', hl.background)
	result.sp = hl.special and string.format('#%06x', hl.special)
	for attr, val in pairs(hl) do
		if
			type(attr) == 'string'
			and attr ~= 'foreground'
			and attr ~= 'background'
			and attr ~= 'special'
		then
			result[attr] = val
		end
	end

	return result
end

---Blend foreground with background
---@param foreground palette|string @The foreground color
---@param background palette|string @The background color to blend with
---@param alpha number|string @Number between 0 and 1 for blending amount.
function M.blend(foreground, background, alpha)
	alpha = type(alpha) == 'string' and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format(
		'#%02x%02x%02x',
		blendChannel(1),
		blendChannel(2),
		blendChannel(3)
	)
end

---@param hl_group string Group in common
---@param hl_name string Highlight name
---@param hl_fg? string Foreground initial color
---@param hl_bg? string Background initial color
---@param opts? table Background initial color
function M.new_hl_value(hl_name, opts)
	-- opts = { bold = true, underline = false }
	local _opts = {}
	if opts then
		for k, v in pairs(opts) do
			_opts[k] = v
		end
	end

	vim.api.nvim_set_hl(0, hl_name, _opts)
	return
end

---Get RGB highlight by highlight group
---@param hl_group string @Highlight group name
---@param use_bg boolean @Returns background or not
---@param fallback_hl? string @Fallback value if the hl group is not defined
---@return string
function M.hl_to_rgb(hl_group, use_bg, fallback_hl)
	local hex = fallback_hl or '#000000'
	local hlexists = pcall(vim.api.nvim_get_hl_by_name, hl_group, true)

	if hlexists then
		local result = get_highlight(hl_group)
		if use_bg then
			hex = result.bg and result.bg or 'NONE'
		else
			hex = result.fg and result.fg or 'NONE'
		end
	end

	return hex
end

---Extend a highlight group
---@param name string @Target highlight group name
---@param def table @Attributes to be extended
function M.extend_hl(name, def)
	local hlexists = pcall(vim.api.nvim_get_hl_by_name, name, true)
	if not hlexists then
		-- Do nothing if highlight group not found
		return
	end
	local current_def = get_highlight(name)
	local combined_def = vim.tbl_deep_extend('force', current_def, def)

	vim.api.nvim_set_hl(0, name, combined_def)
end

---Convert number (0/1) to boolean
---@param value number @The value to check
---@return boolean|nil @Returns nil if failed
function M.tobool(value)
	if value == 0 then
		return false
	elseif value == 1 then
		return true
	else
		vim.notify(
			"Attempt to convert data of type '"
				.. type(value)
				.. "' [other than 0 or 1] to boolean",
			vim.log.levels.ERROR,
			{ title = '[utils] Runtime error' }
		)
		return nil
	end
end

return M
