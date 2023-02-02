require('nvim-treesitter.configs').setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = {
		'bash',
		'go',
		'help',
		'javascript',
		'json',
		'lua',
		'markdown',
		'markdown_inline',
		'query',
		'regex',
		'rust',
		'typescript',
		'yaml',
		'vim',
	},

	highlight = { enable = true },
	indent = { enable = true },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<C-\\>',
			node_incremental = '<C-\\>',
			scope_incremental = '<nop>',
			node_decremental = '<bs>',
		},
	},

	autopairs = {
		enable = false,
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				['aa'] = '@parameter.outer',
				['ia'] = '@parameter.inner',
				['af'] = '@function.outer',
				['if'] = '@function.inner',
				['ac'] = '@class.outer',
				['ic'] = '@class.inner',
			}
		},
	},
	move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = {
			[']m'] = '@function.outer',
			[']]'] = '@class.outer',
		},
		goto_next_end = {
			[']M'] = '@function.outer',
			[']['] = '@class.outer',
		},
		goto_previous_start = {
			['[m'] = '@function.outer',
			['[['] = '@class.outer',
		},
		goto_previous_end = {
			['[M'] = '@function.outer',
			['[]'] = '@class.outer',
		},
	},
	swap = {
		enable = true, swap_next = {
			['<leader>a'] = '@parameter.inner',
		},
		swap_previous = {
			['<leader>A'] = '@parameter.inner',
		},
	}
}
