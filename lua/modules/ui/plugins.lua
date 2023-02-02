local conf = require("modules.ui.config")

return {
	{
		'nvim-lualine/lualine.nvim',
		event = "VeryLazy",
		dependencies = "kyazdani42/nvim-web-devicons",
		opts = require'modules.ui.lualine'
	},

	{
		"rcarriga/nvim-notify",
		keys = {
			{
				"<leader>un",
				function()
					require("notify").dismiss({ silent = true, pending = true })
				end,
				desc = "Delete all Notifications",
			},
		},
		opts = {
			background_colour = "#1e222a",
			timeout = 3000,
			max_height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
		max_width = function()
				return math.floor(vim.o.columns * 0.75)
			end,
		},
	},


	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = conf.alpha,
	},

	{
		"echasnovski/mini.animate",
		version = false,
		config = conf.animate,
	},

	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = require'modules.ui.bufferline'
	},

	{ "akinsho/toggleterm.nvim", lazy = true },


	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			views = {
				cmdline_popup = {
					position = { row = 5, col = "50%" },
					size = { width = 60, height = "auto" },
				},
				popupmenu = {
					relative = "editor",
					position = { row = 6, col = "50%" },
					size = { width = 60, height = 10 },
					border = { style = "rounded", padding = { 0, 1 }, },
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
					},
				},
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = false,
				command_palette = false,
				long_message_to_split = true,
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		},
		-- stylua: ignore
		keys = {
			{ "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
			{ "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
			{ "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
			{ "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
			{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
			{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
		},
	},

	{
		"SmiteshP/nvim-navic",
		lazy = true,
		init = function()
			vim.g.navic_silence = true
			require("utils").on_attach(function(client, buffer)
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buffer)
				end
			end)
		end,
		opts = { separator = " ", highlight = true, depth_limit = 5 },
	},
	{ "MunifTanjim/nui.nvim", lazy = true },

	-- Themes
	{ "rebelot/kanagawa.nvim", lazy = "VeryLazy", },
	{ "folke/tokyonight.nvim", lazy = "VeryLazy", },
	{ "rose-pine/neovim", lazy = "VeryLazy" }
}


