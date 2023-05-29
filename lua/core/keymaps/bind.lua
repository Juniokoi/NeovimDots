-- Code adapted from https://github.com/ayamir/nvimdots
local rhs_options = {}

function rhs_options:new()
	local instance = {
		cmd = '',
		type = '',
		options = {
			noremap = true,
			silent = true,
			expr = false,
			nowait = false,
			desc = '',
		},
		buffer = false,
	}
	setmetatable(instance, self)
	self.__index = self
	return instance
end

-- Functions
function rhs_options:map_cmd(cmd_string)
	self.cmd = cmd_string
	return self
end

function rhs_options:cr(cmd_string)
	self.cmd = (':%s<CR>'):format(cmd_string)
	return self
end

function rhs_options:lua(cmd_string)
	self.cmd = (':lua %s<CR>'):format(cmd_string)
	return self
end

function rhs_options:args(cmd_string)
	self.cmd = (':%s<Space>'):format(cmd_string)
	return self
end

function rhs_options:cu(cmd_string)
	-- <C-u> to eliminate the automatically inserted range in visual mode
	self.cmd = (':<C-u>%s<CR>'):format(cmd_string)
	return self
end

function rhs_options:lazy(cmd_string)
	self.cmd = (':Lazy %s<CR>'):format(cmd_string)
	self.type = 'lazy'
	return self
end

function rhs_options:trouble(cmd_string)
	if string.sub(cmd_string, 1, 1) == '.' then
		self.cmd = (":lua require('trouble')%s<CR>"):format(cmd_string)
	else
		self.cmd = (':TroubleToggle %s<CR>'):format(cmd_string)
	end

	self.type = 'trouble'
	return self
end

function rhs_options:lspsaga(cmd_string)
	self.cmd = (':Lspsaga %s<CR>'):format(cmd_string)
	self.type = 'lspsaga'
	return self
end

function rhs_options:dap(cmd_string)
	self.cmd = (":lua require('dap').%s<CR>"):format(cmd_string)
	self.type = 'dap'
	return self
end

function rhs_options:te(cmd_string)
	if string.sub(cmd_string, 1, 1) == '.' then
		self.cmd = (":lua require('telescope.builtin')%s<CR>"):format(cmd_string)
		self.type = 'telescope_builtin'
	else
		self.cmd = (':Telescope %s<CR>'):format(cmd_string)
		self.type = 'telescope'
	end
	return self
end

-- Options
-- silent
function rhs_options:no_silent()
	self.options.silent = true
	return self
end

-- noremap
function rhs_options:no_remap()
	self.options.noremap = true
	return self
end

-- silent noremap
function rhs_options:sinr()
	self.options.silent = true
	self.options.noremap = true
	return self
end

-- expr
function rhs_options:ex()
	self.options.expr = true
	return self
end

-- nowait
function rhs_options:nw()
	self.options.nowait = true
	return self
end

-- buffer
function rhs_options:bf(num)
	self.buffer = num
	return self
end

-- description
function rhs_options:desc(str)
	local desc = Switch(self.type, {
		['trouble'] = ('[Trouble] %s'):format(str),
		['lsp'] = ('[LSP] %s'):format(str),
		['lazy'] = ('[Lazy] %s'):format(str),
		['lspsaga'] = ('[Lspsaga] %s'):format(str),
		['telescope'] = ('[Telescope] %s'):format(str),
		['telescope_builtin'] = ('[Telescope Builtin] %s'):format(str),
		['default'] = str,
	})

	self.options.desc = desc
	return self
end
--

local pbind = {}
function pbind.map_cmd(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cmd(cmd_string)
end

function pbind.cr(cmd_string)
	local ro = rhs_options:new()
	return ro:cr(cmd_string)
end

function pbind.lua(cmd_string)
	local ro = rhs_options:new()
	return ro:lua(cmd_string)
end

function pbind.cu(cmd_string)
	local ro = rhs_options:new()
	return ro:cu(cmd_string)
end

function pbind.args(cmd_string)
	local ro = rhs_options:new()
	return ro:args(cmd_string)
end

function pbind.lazy(cmd_string)
	local ro = rhs_options:new()
	return ro:lazy(cmd_string)
end

-- plugin: Trouble(folke)
function pbind.trouble(cmd_string)
	local ro = rhs_options:new()
	return ro:trouble(cmd_string)
end

function pbind.lspsaga(cmd_string)
	local ro = rhs_options:new()
	return ro:lspsaga(cmd_string)
end

function pbind.dap(cmd_string)
	local ro = rhs_options:new()
	return ro:dap(cmd_string)
end

function pbind.te(cmd_string)
	local ro = rhs_options:new()
	return ro:te(cmd_string)
end
function pbind.tb(cmd_string)
	local ro = rhs_options:new()
	return ro:tb(cmd_string)
end

local function filter(mode)
	if mode:find(',') then
		local _m = mode
		mode = {}
		for k in string.gmatch(_m, '%w+') do
			table.insert(mode, k)
		end
	else
		mode = mode
	end
	return mode
end

local function set_keybindinds(o)
	local mode, keys, rhs, opt, buf = o.mode, o.keymap, o.rhs, o.opts, o.buffer
	if type(mode) == 'table' then
		for _, mode_value in ipairs(mode) do
			if buf then
				vim.api.nvim_buf_set_keymap(buf, mode_value, keys, rhs, opt)
			else
				vim.keymap.set(mode_value, keys, rhs, opt)
			end
		end
	else
		if buf then
			vim.api.nvim_buf_set_keymap(buf, mode, keys, rhs, opt)
		else
			vim.keymap.set(mode, keys, rhs, opt)
		end
	end
end

function pbind.load_mapping(mapping)
	for key, value in pairs(mapping) do
		local mode, keymap = key:match('([^|]*)|?(.*)')
		mode = filter(mode)
		set_keybindinds({
			mode = mode,
			keymap = keymap,
			rhs = value.cmd,
			opts = value.options,
			buffer = value.buffer, -- optional
		})
	end
end
return pbind
