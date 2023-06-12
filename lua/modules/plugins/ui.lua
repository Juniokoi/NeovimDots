local ui = {}

--ui['lukas-reineke/indent-blankline.nvim'] = {
	--opts = {
		--char = '┊',
		--show_trailing_blankline_indent = false,
	--},
--}

ui["RRethy/vim-illuminate"] = {
	event = "BufRead",
	name = 'illuminate',
	config = Load('ui.illuminate'),
}

ui["goolord/alpha-nvim"] = {
	event = "VimEnter",
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		require'alpha'.setup(require'alpha.themes.startify'.config)
	end
}
ui['nvim-lualine/lualine.nvim'] = {
	event = "BufRead",
	config = Load('ui.lualine')
}

ui['rose-pine/neovim'] = {
	lazy = false,
	name = 'rose-pine',
	event = 'VimEnter',
	config = function()
		require('rose-pine').setup {
			 	disable_background = true,
				disable_float_background = true,
				dim_nc_background = true,
		}
		vim.cmd.colorscheme 'rose-pine'
	end
}

return ui
