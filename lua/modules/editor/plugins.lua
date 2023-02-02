local config = { require'modules.editor.config' }

return {
	-- Autopairs
	{ "karb94/neoscroll.nvim", config = config.neoscroll },
	{ "windwp/nvim-autopairs", config = config.npairs }, -- Autopairs, integrates with both cmp and treesitter
	{ "numToStr/Comment.nvim", config = true }, -- Easily comment stuff
	{ "phaazon/hop.nvim",
		version = 'v2', -- optional but strongly recommended
		config = function()
			require('hop').setup(
				{ keys = 'etovxqpdygfblzhckisuran' }
			)
		end,
		opts = function()
			local hop = require('hop')
			local directions = require('hop.hint').HintDirection

			vim.keymap.set('', 'f', function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set('', 'F', function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set('', 't', function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set('', 'T', function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
			end, { remap = true })
		end
	},
	{ "kylechui/nvim-surround", config = true },
	{ "ThePrimeagen/harpoon", config = true },
	{ "github/copilot.vim" },
	{
		"abecodes/tabout.nvim",
		config = config.tabout,
	},
	{ "nvim-lua/popup.nvim" },
	{
		"mg979/vim-visual-multi",
		name = "multicursor"
	},

	{ "folke/zen-mode.nvim" },
	{ "norcalli/nvim-colorizer.lua", opts = {
			'*'
		} },
	{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically
}
