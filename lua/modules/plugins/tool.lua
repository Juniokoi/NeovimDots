local tool = {}

tool['nvim-telescope/telescope.nvim']= {
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-project.nvim',
		'nvim-telescope/telescope-media-files.nvim',
		'nvim-telescope/telescope-file-browser.nvim',
		'nvim-telescope/telescope-frecency.nvim',
		'jvgrootveld/telescope-zoxide',
		'kkharji/sqlite.lua',
	}
}

tool['nvim-telescope/telescope-fzf-native.nvim'] = {
	build = 'make',
	cond = function()
		return vim.fn.executable 'make' == 1
	end,
	config = Load('tool.telescope')
}

tool['tpope/vim-fugitive'] = {}
tool['tpope/vim-rhubarb'] = {}
tool['tpope/vim-sleuth'] = {}

tool["gelguy/wilder.nvim"] = {
	event = "CmdlineEnter",
	config = Load("tool.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}

tool['nvim-treesitter/nvim-treesitter'] = {
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
	build = ':TSUpdate',
}

tool['numToStr/Comment.nvim'] = {}
tool['folke/which-key.nvim'] = {}
tool['kylechui/nvim-surround'] = {
	event = "VeryLazy",
	config = true,
}

return tool
