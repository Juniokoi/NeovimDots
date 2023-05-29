local global = Load('core.global')
-- Create cache dir and data dirs
local function createdir()
	local data_dir = {
		global.cache_dir .. 'backup',
		global.cache_dir .. 'session',
		global.cache_dir .. 'swap',
		global.cache_dir .. 'tags',
		global.cache_dir .. 'undo',
	}
	-- Only check whether cache_dir exists, this would be enough.
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute('mkdir -p ' .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then os.execute('mkdir -p ' .. v) end
		end
	end
end

local function clipboard_config()
	if global.is_mac then
		vim.g.clipboard = {
			name = 'macOS-clipboard',
			copy = { ['+'] = 'pbcopy', ['*'] = 'pbcopy' },
			paste = { ['+'] = 'pbpaste', ['*'] = 'pbpaste' },
			cache_enabled = 0,
		}
	elseif global.is_wsl then
		vim.g.clipboard = {
			name = 'win32yank-wsl',
			copy = {
				['+'] = 'win32yank.exe -i --crlf',
				['*'] = 'win32yank.exe -i --crlf',
			},
			paste = {
				['+'] = 'win32yank.exe -o --lf',
				['*'] = 'win32yank.exe -o --lf',
			},
			cache_enabled = 0,
		}
	end
end

local function neovide_config()
	vim.api.nvim_set_option_value('guifont', 'JetBrainsMono Nerd Font:h15', {})
	vim.g.neovide_refresh_rate = 120
	vim.g.neovide_cursor_vfx_mode = 'railgun'
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_cursor_trail_length = 0.05
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_speed = 20.0
	vim.g.neovide_cursor_vfx_particle_density = 5.0
end

local function set_leader_key()
	vim.keymap.set('', '<Space>', '<Nop>')
	vim.g.mapleader = ' '
	vim.g.maplocalleader = ' '
	vim.opt.termguicolors = true -- TODO necessary for plugin colorful
end

createdir()
neovide_config()
clipboard_config()
set_leader_key()
