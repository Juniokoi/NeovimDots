return function()
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
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = Load("cmp_nvim_lsp").default_capabilities(capabilities)
	require("rust-tools").setup {
		tools = {
			inlay_hints = {
				auto = true,
				only_current_line = false,
				show_parameter_hints = true,
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
						allFeatures = true
					},
					staticcheck = true,
					checkOnSave = {
						command = "clippy",
						extraArgs = {
							"--",
							"-W clippy::pedantic",
							"-W clippy::nursery",
							"-W clippy::unwrap_used",
						},
					},
				},
			},
		},
	}
end
