local conf = require("modules.utils.config")

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		opts = conf.neotree
	},
	{ "akinsho/toggleterm.nvim", opts = conf.toggleterm },
	{ "tpope/vim-rhubarb" },

	{ "moll/vim-bbye", cmd = "Bdelete" }, -- Close window without messing up with layout

	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-project.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-frecency.nvim",
			"kkharji/sqlite.lua"
		},
		config = conf.telescope
	},
}
