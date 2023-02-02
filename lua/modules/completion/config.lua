local config = {}

function config.lsp()
	require("modules.completion.lisp")
end

function config.cmp()
	require("modules.completion.cmp")
end

function config.blankline()
	require('indent_blankline').setup {
		char = "▏",
		filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
		space_char_blankline = " ",
		show_current_context = true,
		show_trailing_blankline_indent = false,


		context_highlight_list = {
			"ContextBlanklineIndent1",
			"ContextBlanklineIndent2",
			"ContextBlanklineIndent3",
			"ContextBlanklineIndent4",
			"ContextBlanklineIndent5",
			"ContextBlanklineIndent6",
		},
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
		},
	}
end

function config.gitsigns()
	require('gitsigns').setup {
		signs = {
			add = { text = '+' },
			change = { text = '~' },
			delete = { text = '_' },
			topdelete = { text = '‾' },
			changedelete = { text = '~' },
		},
	}
end

function config.treesitter()
	require 'modules.completion.treesitter'
end

function config.dap()
	return 'modules.completion.debugger'
end

return config
