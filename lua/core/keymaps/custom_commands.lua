vim.keymap.set({ 'n', 'i' }, '<A-c>', function()
	local copilot_keys = vim.fn['copilot#Accept']('')
	if copilot_keys ~= nil then vim.api.nvim_feedkeys(copilot_keys, 'i', false) end
end)

vim.keymap.set('n', '<leader>zz', function()
	require('zen-mode').setup({
		window = {
			width = vim.api.nvim_win_get_width(0) - 40,
			options = {},
		},
	})
	require('zen-mode').toggle()
	vim.opt_local.wrap = true
	vim.opt_local.number = false
	vim.opt_local.rnu = false
end)

vim.keymap.set('n', '<leader>zZ', function()
	require('zen-mode').setup({
		window = {
			width = 80,
			options = {},
		},
	})
	require('zen-mode').toggle()
	vim.opt_local.wrap = false
	vim.opt_local.number = false
	vim.opt_local.rnu = false
	vim.opt_local.colorcolumn = '0'
end)

vim.api.nvim_create_user_command('Format', function(o)
	local opts = o.args
	local cwd = vim.fn.getcwd()

	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_active_clients()

	if opts.filter then
		clients = opts.filter(clients)
	elseif opts.id then
		clients = vim.tbl_filter(
			function(client) return client.id == opts.id end,
			clients
		)
	elseif opts.name then
		clients = vim.tbl_filter(
			function(client) return client.name == opts.name end,
			clients
		)
	end

	clients = vim.tbl_filter(
		function(client) return client.supports_method('textDocument/formatting') end,
		clients
	)

	if #clients == 0 then
		vim.notify(
			'[LSP] Format request failed, no matching language servers.',
			vim.log.levels.WARN,
			{ title = 'Formatting Failed!' }
		)
	end

	local timeout_ms = opts.timeout_ms
	for _, client in pairs(clients) do
		local params = vim.lsp.util.make_formatting_params(opts.formatting_options)
		local result, err =
			client.request_sync('textDocument/formatting', params, timeout_ms, bufnr)
		if result and result.result then
			vim.lsp.util.apply_text_edits(result.result, bufnr, client.offset_encoding)
			vim.notify(
				string.format('[LSP] Format successfully with [%s]!', client.name),
				vim.log.levels.INFO,
				{ title = 'LSP Format Success!' }
			)
		elseif err then
			vim.notify(
				string.format('[LSP][%s] %s', client.name, err),
				vim.log.levels.ERROR,
				{ title = 'LSP Format Error!' }
			)
		end
	end
end, { desc = 'Format current buffer with LSP' })

local M = {}
local path = '~/.config/nvim'

function M.edit_keymaps() vim.cmd("e " .. path .. "/lua/core/keymaps/init.lua") end
function M.edit_custom() vim.cmd('e ' .. path .. '/lua/core/keymaps/custom_commands.lua') end
function M.get_highlight()
	vim.cmd('source ~/.config/nvim/lua/misc/colors/shared/custom_highlights.lua')
end

function M.getback_cd()
	local cwd = vim.fn.getcwd()
	local home = os.getenv('HOME')
	if cwd:find(home, 1, true) == 1 then cwd = cwd:sub(#home + 1) end
	vim.cmd('lcd' .. cwd .. '<CR>')
end

function M.local_git()
	Load("telescope.builtin").git_files({
		shorthen_path = true,
		cwd = vim.fn.getcwd(),
	})
end

function M.local_recent()
	Load("telescope.builtin").oldfiles({
		shorthen_path = true,
		cwd = vim.fn.getcwd(),
		prompt = '~ Local Recent ~',
		height = 10,

		layout_strategy = 'horizontal',
		layout_options = {
			preview_width = 0.75,
		},
	})
end

function M.treesitter() Load('nvim-treesitter-playground.hl-info').get_treesitter_hl() end

function M.zoxide()
	Load("telescope").extensions.zoxide.list({
		shorthen_path = false,
		prompt = '~ Zoxide ~',
		height = 10,

		layout_strategy = 'horizontal',
		layout_options = {
			preview_width = 0.75,
		},
	})
end

function M.global_recent()
	Load("telescope.builtin").oldfiles({
		shorthen_path = true,
		prompt = '~ Global Recent ~',
		height = 10,

		layout_strategy = 'horizontal',
		layout_options = {
			preview_width = 0.75,
		},
	})
end

function M.config()
	Load("telescope.builtin").git_files({
		shorthen_path = true,
		cwd = path,
		prompt = '~ Neovim ~',
		height = 10,

		layout_strategy = 'horizontal',
		layout_options = {
			preview_width = 0.75,
		},
	})
end

function M.load()
	U.add_fn("Custom", M)
end

return M
