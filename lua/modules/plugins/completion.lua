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

comp["jay-babu/mason-null-ls.nvim"] = {
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"jose-elias-alvarez/null-ls.nvim",
	},
	config = Load('completion.null'),
}

comp['hrsh7th/nvim-cmp'] = {
	event = "InsertEnter",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			dependencies = { "rafamadriz/friendly-snippets" },
			config = require("completion.luasnip"),
		},
		{ "lukas-reineke/cmp-under-comparator" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "andersevenrud/cmp-tmux" },
		{ "hrsh7th/cmp-path" },
		{ "f3fora/cmp-spell" },
		{ "hrsh7th/cmp-buffer" },
		{ "kdheepak/cmp-latex-symbols" },
		{ "ray-x/cmp-treesitter", commit = "c8e3a74" },
	},
	config = Load('completion.cmp')
}

comp["zbirenbaum/copilot.lua"] = {
	lazy = true,
	cmd = "Copilot",
	event = "InsertEnter",
	config = true,
	dependencies = {
		{ "zbirenbaum/copilot-cmp", config = true },
	},
}

comp['folke/trouble.nvim'] = {
	cmd = { 'Trouble', 'TroubleToggle', 'TroubleRefresh', 'TroubleClose' },
	setup = true,
}

return comp
