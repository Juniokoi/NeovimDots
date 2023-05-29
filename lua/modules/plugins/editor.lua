local editor = {}

editor['nvim-treesitter/nvim-treesitter'] = {
	event = "BufRead",
	build = function()
		require('nvim-treesitter.install').update({ with_sync = true })
	end,
	config = require('editor.treesitter'),
}

editor['lewis6991/gitsigns.nvim'] = {
	opts = {
		-- See `:help gitsigns.txt`
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
		on_attach = function(bufnr)
		local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
		vim.api.nvim_create_autocmd('TextYankPost', {
			callback = function()
				vim.highlight.on_yank()
			end,
			group = highlight_group,
			pattern = '*',
		})
			vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
			vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
			vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
		end,
	},
}

return editor
