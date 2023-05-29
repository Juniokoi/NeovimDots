local ui = {}

ui['lukas-reineke/indent-blankline.nvim'] = {
	opts = {
		char = '┊',
		show_trailing_blankline_indent = false,
	},
}

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

ui['rose-pine/neovim'] = {
	lazy = false,
	name = 'rose-pine',
	event = 'VimEnter',
	config = function()
		vim.cmd.colorscheme 'rose-pine'
	end
}

return ui
