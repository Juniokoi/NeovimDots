local comp = {}

comp['neovim/nvim-lspconfig'] = {
	event = { 'BufNewFile' },
	config = Load('completion.lsp'),
	dependencies = {
		{ 'ray-x/lsp_signature.nvim' },
		{ 'williamboman/mason.nvim' },
		{ 'williamboman/mason-lspconfig.nvim' },
		{ 'b0o/SchemaStore.nvim' },
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'folke/neoconf.nvim',               cmd = 'Neoconf' },
		{ 'folke/neodev.nvim',                opts = { experimental = { pathStrict = true } }, },
		{ 'glepnir/lspsaga.nvim',             config = Load('completion.lspsaga') },
		{ 'j-hui/fidget.nvim'},
		{ 'ray-x/lsp_signature.nvim' },
	}
}

comp['jose-elias-alvarez/null-ls.nvim'] = {
	event = { 'BufReadPre', 'BufNewFile' },
	config = Load('completion.null'),
}

comp["zbirenbaum/copilot.lua"] = {
	lazy = true,
	cmd = "Copilot",
	event = "InsertEnter",
	config = Load("completion.copilot"),
	dependencies = {
		{
			"zbirenbaum/copilot-cmp",
			config = Load("completion.copilot_cmp"),
		},
	},
}

comp['folke/trouble.nvim'] = {
	cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh', 'TroubleClose' },
	setup = true,
}

return comp
