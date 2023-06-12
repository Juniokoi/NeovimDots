local langs = {}

langs['ray-x/go.nvim'] = {
	dependencies = {  -- optional packages
	"ray-x/guihua.lua",
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup()
	end,
	event = {"CmdlineEnter"},
	ft = {"go", 'gomod'},
	build = ':lua require("go.install").update_all_sync()',
}

langs["simrat39/rust-tools.nvim"] = {
	ft = 'rust',
	dependencies = {
		{ 'ray-x/lsp_signature.nvim' },
		"nvim-lua/plenary.nvim"
	},
	config = Load("langs.rust"),
}

langs["Saecki/crates.nvim"] = {
	event = "BufReadPost Cargo.toml",
	config = Load("langs.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}

return langs
