local conf = require('modules.completion.config')

return {
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			-- lsp support
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"jose-elias-alvarez/null-ls.nvim",
			"b0o/SchemaStore.nvim",
			-- json schemas
		},
		config = conf.lsp
	},
	{
		"lewis6991/gitsigns.nvim",
		config = conf.gitsigns
	},
	  -- snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<C-j>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<C-j>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<C-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			'hrsh7th/cmp-nvim-lsp-signature-help',
			'hrsh7th/cmp-cmdline',
			'tamago324/cmp-zsh',
			"saadparwaiz1/cmp_luasnip",
			"JoosepAlviste/nvim-ts-context-commentstring", -- Comment on .TS Files
			"windwp/nvim-ts-autotag",
			"onsails/lspkind.nvim"
		},
		opts = conf.cmp
	},

	-- auto pairs
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},

	-- surround
	{
		"echasnovski/mini.surround",
		keys = function(plugin, keys)
			-- Populate the keys based on the user's options
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local mappings = {
				{ opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
				{ opts.mappings.delete, desc = "Delete surrounding" },
				{ opts.mappings.find, desc = "Find right surrounding" },
				{ opts.mappings.find_left, desc = "Find left surrounding" },
				{ opts.mappings.highlight, desc = "Highlight surrounding" },
				{ opts.mappings.replace, desc = "Replace surrounding" },
				{ opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			mappings = {
				add = "gza", -- Add surrounding in Normal and Visual modes
				delete = "gzd", -- Delete surrounding
				find = "gzf", -- Find surrounding (to the right)
				find_left = "gzF", -- Find surrounding (to the left)
				highlight = "gzh", -- Highlight surrounding
				replace = "gzr", -- Replace surrounding
				update_n_lines = "gzn", -- Update `n_lines`
			},
		},
		config = function(_, opts)
			-- use gz mappings instead of s to prevent conflict with leap
			require("mini.surround").setup(opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		config = conf.blankline
	},

	{ "j-hui/fidget.nvim", config = true },
	{ "folke/neodev.nvim", config = true },

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/playground",
			"nvim-treesitter/nvim-treesitter-textobjects"
		},
		config = conf.treesitter,
		build = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = conf.dap
	},

	{
		"elkowar/yuck.vim",
		dependencies = {
			"gpanders/nvim-parinfer"
		}
	},
}
