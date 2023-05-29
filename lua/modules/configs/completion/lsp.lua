return function()
	local lspconfig = require('lspconfig')
	local mason = Load("mason")
	local mason_lspconfig = Load("mason-lspconfig")

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = {
				severity = { min = vim.diagnostic.severity.WARN },
			},
			virtual_text = {
				spacing = 4,
				severity = { min = vim.diagnostic.severity.INFO },
				format = function() return "" end
			},
			update_on_insert = false,
	})

	local icons = {
		ui = require("util.icons").get("ui", true),
		misc = require("util.icons").get("misc", true),
	}

	local servers = {
		astro = {},
		ansiblels = {},
		bashls = {
			cmd = { "bash-language-server", "start" },
			filetypes = { "bash", "sh" },
		},
		clangd = {},
		denols = {},
		cssls = {},
		dockerls = {},
		svelte = {},
		quick_lint_js = {},
		html = {},
		gopls = {
			use_mason = false,
			cmd = { "gopls", "-remote=auto" },
			settings = {
				gopls = {
					experimentalPostfixCompletions = true,
					usePlaceholders = true,
					analyses = {
						nilness = true,
						shadow = true,
						unusedparams = true,
						unusewrites = true,
					},
				},
			},
		},
		jsonls = {
			flags = { debounce_text_changes = 500 },
			settings = {
				json = {
					-- Schemas https://www.schemastore.org
					schemas = {
						{
							fileMatch = { "package.json" },
							url = "https://json.schemastore.org/package.json",
						},
						{
							fileMatch = { "tsconfig*.json" },
							url = "https://json.schemastore.org/tsconfig.json",
						},
						{
							fileMatch = {
								".prettierrc",
								".prettierrc.json",
								"prettier.config.json",
							},
							url = "https://json.schemastore.org/prettierrc.json",
						},
						{
							fileMatch = { ".eslintrc", ".eslintrc.json" },
							url = "https://json.schemastore.org/eslintrc.json",
						},
						{
							fileMatch = {
								".babelrc",
								".babelrc.json",
								"babel.config.json",
							},
							url = "https://json.schemastore.org/babelrc.json",
						},
						{
							fileMatch = { "lerna.json" },
							url = "https://json.schemastore.org/lerna.json",
						},
						{
							fileMatch = {
								".stylelintrc",
								".stylelintrc.json",
								"stylelint.config.json",
							},
							url = "http://json.schemastore.org/stylelintrc.json",
						},
						{
							fileMatch = { "/.github/workflows/*" },
							url = "https://json.schemastore.org/github-workflow.json",
						},
					},
				},
			},
		},
		marksman = {},
		pyright = {},
		yamlls = {
			settings = {
				yaml = {
					keyOrdering = false,
				},
			},
		},
		lua_ls = {
			use_mason = false,
			-- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
			single_file_support = true,
			settings = {
				Lua = {
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						maxPreload = 100000,
						preloadFileSize = 10000,
						checkThirdParty = false,
					},
					completion = {
						workspaceWord = true,
						callSnippet = "Both",
					},
					misc = {
						parameters = {
							"--log-level=trace",
						},
					},
					diagnostics = {
						-- enable = false,
						--
						globals = { "vim" },
						disable = { "different-requires" },
						groupSeverity = {
							strong = "Warning",
							strict = "Warning",
						},
						groupFileStatus = {
							["ambiguity"] = "Opened",
							["await"] = "Opened",
							["codestyle"] = "None",
							["duplicate"] = "Opened",
							["global"] = "Opened",
							["luadoc"] = "Opened",
							["redefined"] = "Opened",
							["strict"] = "Opened",
							["strong"] = "Opened",
							["type-check"] = "Opened",
							["unbalanced"] = "Opened",
							["unused"] = "Opened",
						},
						unusedLocalExclude = { "_*" },
					},
					format = {
						enable = false,
						defaultConfig = {
							indent_style = "tab",
							indent_size = "4",
							continuation_indent_size = "4",
						},
					},
				},
			},
		},
		vimls = {},
		tailwindcss = {},
	}

	local exclude = {}
	local ensure = {}
	for server_name,_ in pairs(servers) do
		if servers[server_name].use_mason == false then
			table.insert(exclude, tostring(server_name))
		else
			table.insert(ensure, tostring(server_name))
		end
	end

	mason.setup({
        automatic_installation = { exclude = exclude },
        PATH = "append", -- Mason binaries at the end of path variable
		ui = {
			border = "rounded",
			icons = {
				package_pending = icons.ui.Modified_alt,
				package_installed = icons.ui.Check,
				package_uninstalled = icons.misc.Ghost,
			},
			keymaps = {
				toggle_server_expand = "<CR>",
				install_server = "i",
				update_server = "U",
				check_server_version = "c",
				update_all_servers = "u",
				check_outdated_servers = "C",
				uninstall_server = "x",
				cancel_installation = "<C-c>",
			},
		},
	})

	mason_lspconfig.setup({
		ensure_installed = ensure
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = Load("cmp_nvim_lsp").default_capabilities(capabilities)
	local on_attach = function()
			require("lsp_signature").on_attach({
				bind = true,
				use_lspsaga = true,
				floating_window = true,
				fix_pos = true,
				hint_enable = true,
				hi_parameter = "Search",
				handler_opts = {
					border = "rounded",
				},
			})
		end

	local opts = {
		on_attach = on_attach(),
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	mason_lspconfig.setup_handlers({
		function (lsp_name)
			lspconfig[lsp_name].setup(vim.tbl_deep_extend("force", opts, servers[lsp_name]))
		end
	})

	for _,server_name in pairs(exclude) do
		lspconfig[server_name].setup({
			vim.tbl_deep_extend("force",opts, servers[server_name])
		})
	end

	-- Custom servers
	require("rust-tools").setup {
		tools = {
			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = false,
				parameter_hints_prefix = '<- ',
				other_hints_prefix = '=> ',
				max_len_align = false,
				max_len_align_padding = 1,
				right_align = false,
				right_align_padding = 4,
				highlight = 'Comment',
			},
			hover_actions = {
				border = {
					{ '╭', 'FloatBorder' },
					{ '─', 'FloatBorder' },
					{ '╮', 'FloatBorder' },
					{ '│', 'FloatBorder' },
					{ '╯', 'FloatBorder' },
					{ '─', 'FloatBorder' },
					{ '╰', 'FloatBorder' },
					{ '│', 'FloatBorder' },
				},
				auto_focus = false,
			},
		},
		server = {
			on_attach = on_attach(),
			capabilities = capabilities,
			cmd = {
				"rustup",
				"run",
				"stable",
				"rust-analyzer"
			},
			settings = {
				["rust-analyzer"] = {
					procMacro = { enable = true },
					cargo = {
						features = { "exercises" },
						allFeatures = true
					},
					staticcheck = true,
					checkOnSave = {
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
				},
			},
		},
	}

	require("go").setup({
		disable_defaults = false,
		max_line_len = 90,
		lsp_inlay_hints = {
			enable = true,
			show_variable_name = false,
		}
	})
end
